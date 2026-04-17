# Backend do Project Hyperion

Este diretório contém o watchdog de segurança em Python para o servidor/TV Box ARM.

## Conteúdo

- `watchdog.py`: servidor TLS que valida HWID, aplica rate limiting e checa integridade de arquivos.
- `hwid_allowlist.json`: lista de HWIDs autorizados.
- `blacklist_hashes.json`: hashes SHA-256 de conteúdos proibidos.

## Como executar

```bash
python backend/watchdog.py
```

## Configuração

- Geração de certificado TLS e chave em `backend/server.pem` e `backend/server.key`
- Atualize `backend/hwid_allowlist.json` com HWIDs válidos
- Atualize `backend/blacklist_hashes.json` com hashes de arquivos proibidos
