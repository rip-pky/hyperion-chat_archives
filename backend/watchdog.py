#!/usr/bin/env python3
"""
Watchdog de segurança para Project Hyperion.
Executa no servidor/TV Box ARM e gerencia autenticação HWID, rate limiting,
verificação de integridade e conexão TCP/IP criptografada.
"""

import hashlib
import json
import logging
import os
import platform
import ssl
import socket
import threading
import time
from collections import defaultdict, deque
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
BLACKLIST_FILE = BASE_DIR / "blacklist_hashes.json"
HWID_ALLOWLIST = BASE_DIR / "hwid_allowlist.json"

logging.basicConfig(level=logging.INFO, format="[%(asctime)s] %(levelname)s: %(message)s")

RATE_LIMIT_WINDOW = 10  # segundos
MAX_ATTEMPTS = 10
BAN_TIME = 300  # segundos


def load_json(path):
    if not path.exists():
        return {}
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def get_server_hwid():
    parts = []
    if hasattr(platform, "machine"):
        parts.append(platform.machine())
    if hasattr(platform, "node"):
        parts.append(platform.node())
    if hasattr(platform, "system"):
        parts.append(platform.system())
    if hasattr(platform, "release"):
        parts.append(platform.release())
    try:
        parts.append(os.getlogin())
    except OSError:
        parts.append("unknown")

    system_data = "|".join(part for part in parts if part)
    return hashlib.sha256(system_data.encode("utf-8")).hexdigest()


class RateLimiter:
    def __init__(self):
        self.counters = defaultdict(deque)
        self.banned = {}
        self.lock = threading.Lock()

    def allow(self, client_id):
        now = time.monotonic()
        with self.lock:
            if client_id in self.banned and now < self.banned[client_id]:
                return False
            if client_id in self.banned and now >= self.banned[client_id]:
                del self.banned[client_id]

            q = self.counters[client_id]
            while q and now - q[0] > RATE_LIMIT_WINDOW:
                q.popleft()
            q.append(now)
            if len(q) > MAX_ATTEMPTS:
                self.banned[client_id] = now + BAN_TIME
                logging.warning("Banido %s por ataque de força bruta/spam", client_id)
                return False
            return True


class IntegrityChecker:
    def __init__(self):
        self.blacklist_hashes = set(load_json(BLACKLIST_FILE).get("hashes", []))

    def check_file(self, file_bytes):
        file_hash = hashlib.sha256(file_bytes).hexdigest()
        if file_hash in self.blacklist_hashes:
            logging.warning("Integridade falhou para hash %s", file_hash)
            return False
        return True


class HWIDAuthenticator:
    def __init__(self):
        self.authorized = set(load_json(HWID_ALLOWLIST).get("hwids", []))

    def verify(self, hwid):
        if hwid in self.authorized:
            return True
        logging.warning("HWID inválido: %s", hwid)
        return False


class SecureServer:
    def __init__(self, host="0.0.0.0", port=4433):
        self.host = host
        self.port = port
        self.rate_limiter = RateLimiter()
        self.integrity_checker = IntegrityChecker()
        self.authenticator = HWIDAuthenticator()

        self.context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
        cert_path = BASE_DIR / "server.pem"
        key_path = BASE_DIR / "server.key"
        self.context.load_cert_chain(certfile=str(cert_path), keyfile=str(key_path))

    def serve_forever(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0) as sock:
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            sock.bind((self.host, self.port))
            sock.listen(5)
            logging.info("Servidor seguro escutando em %s:%s", self.host, self.port)
            while True:
                client, address = sock.accept()
                threading.Thread(target=self.handle_client, args=(client, address), daemon=True).start()

    def handle_client(self, raw_sock, address):
        peer = f"{address[0]}:{address[1]}"
        logging.info("Nova conexão de %s", peer)
        try:
            with self.context.wrap_socket(raw_sock, server_side=True) as ssock:
                ssock.settimeout(10)
                if not self.perform_handshake(ssock, peer):
                    return
                self.receive_loop(ssock, peer)
        except ssl.SSLError as exc:
            logging.error("Erro SSL %s: %s", peer, exc)
        except socket.timeout:
            logging.warning("Timeout do cliente %s", peer)
        except Exception as exc:
            logging.exception("Erro no cliente %s: %s", peer, exc)

    def perform_handshake(self, ssock, peer):
        raw = ssock.recv(1024)
        if not raw:
            return False

        try:
            payload = json.loads(raw.decode("utf-8"))
            hwid = payload.get("hwid", "")
            if not self.rate_limiter.allow(peer):
                return False
            if not self.authenticator.verify(hwid):
                ssock.send(b"{\"status\": \"denied\"}\n")
                return False
            ssock.send(b"{\"status\": \"ok\"}\n")
            return True
        except Exception:
            logging.exception("Handshake inválido de %s", peer)
            return False

    def receive_loop(self, ssock, peer):
        while True:
            header = ssock.recv(8)
            if not header:
                break
            opcode = header[:4].decode("utf-8", errors="ignore")
            length = int.from_bytes(header[4:], byteorder="big")
            payload = ssock.recv(length)
            if not payload:
                break
            if not self.rate_limiter.allow(peer):
                break

            if opcode == "TEXT":
                message = payload.decode("utf-8", errors="ignore")
                logging.info("[%s] texto: %s", peer, message)
                ssock.send(b"RECV")
            elif opcode == "MEDI":
                if self.integrity_checker.check_file(payload):
                    logging.info("[%s] mídia recebida com integridade verificada", peer)
                    ssock.send(b"RECV")
                else:
                    ssock.send(b"BANN")
                    break
            else:
                logging.warning("Opcode desconhecido %s de %s", opcode, peer)
                break


if __name__ == "__main__":
    server = SecureServer()
    server.serve_forever()
