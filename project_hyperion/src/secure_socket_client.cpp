#include "secure_socket_client.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QSslSocket>
#include <QSslError>
#include <QtEndian>

SecureSocketClient::SecureSocketClient(QObject *parent)
    : QObject(parent)
    , socket(new QSslSocket(this))
{
    connect(socket.data(), &QSslSocket::readyRead, this, &SecureSocketClient::onReadyRead);
    connect(socket.data(), &QSslSocket::encrypted, this, &SecureSocketClient::onConnected);
    connect(socket.data(), &QSslSocket::sslErrors, this, &SecureSocketClient::onSslErrors);
    connect(socket.data(), QOverload<QAbstractSocket::SocketError>::of(&QAbstractSocket::errorOccurred),
            this, &SecureSocketClient::onErrorOccurred);
}

SecureSocketClient::~SecureSocketClient() = default;

void SecureSocketClient::connectToServer(const QString &host, quint16 port)
{
    authenticated = false;
    socket->connectToHostEncrypted(host, port);
}

void SecureSocketClient::setHwId(const QString &hwid)
{
    clientHwId = hwid;
}

static QByteArray buildFrame(const char type[4], const QByteArray &payload)
{
    QByteArray frame;
    frame.append(type, 4);
    quint32 length = qToBigEndian<quint32>(static_cast<quint32>(payload.size()));
    frame.append(reinterpret_cast<const char *>(&length), sizeof(length));
    frame.append(payload);
    return frame;
}

void SecureSocketClient::sendTextMessage(const QString &message)
{
    if (!authenticated) {
        emit errorOccurred(tr("Handshake não concluído."));
        return;
    }
    if (!socket->isEncrypted()) {
        emit errorOccurred(tr("Socket não está criptografado."));
        return;
    }

    QByteArray payload = message.toUtf8();
    QByteArray frame = buildFrame("TEXT", payload);
    socket->write(frame);
    socket->flush();
}

void SecureSocketClient::sendMedia(const QByteArray &mediaBuffer)
{
    if (!authenticated) {
        emit errorOccurred(tr("Handshake não concluído."));
        return;
    }
    if (!socket->isEncrypted()) {
        emit errorOccurred(tr("Socket não está criptografado."));
        return;
    }

    QByteArray frame = buildFrame("MEDI", mediaBuffer);
    socket->write(frame);
    socket->flush();
}

void SecureSocketClient::onReadyRead()
{
    QByteArray data = socket->readAll();
    if (!authenticated) {
        QJsonParseError error;
        QJsonDocument doc = QJsonDocument::fromJson(data, &error);
        if (error.error == QJsonParseError::NoError && doc.isObject()) {
            const QJsonObject obj = doc.object();
            if (obj.value("status").toString() == QLatin1String("ok")) {
                authenticated = true;
                emit connected();
                return;
            }
            emit errorOccurred(tr("Handshake recusado pelo servidor."));
            return;
        }
    }

    if (data.contains('R')) {
        emit messageReceived(tr("Mensagem recebida pelo servidor."));
    } else if (data.contains('B')) {
        emit errorOccurred(tr("Servidor bloqueou a conexão."));
    }
}

void SecureSocketClient::onConnected()
{
    sendHandshake();
}

void SecureSocketClient::onSslErrors(const QList<QSslError> &errors)
{
    Q_UNUSED(errors);
    socket->ignoreSslErrors();
}

void SecureSocketClient::sendHandshake()
{
    if (clientHwId.isEmpty()) {
        emit errorOccurred(tr("HWID não configurado."));
        return;
    }

    QJsonObject obj;
    obj[QStringLiteral("hwid")] = clientHwId;
    QJsonDocument doc(obj);
    socket->write(doc.toJson(QJsonDocument::Compact));
    socket->flush();
}

void SecureSocketClient::onErrorOccurred(QAbstractSocket::SocketError socketError)
{
    Q_UNUSED(socketError);
    emit errorOccurred(socket->errorString());
}
