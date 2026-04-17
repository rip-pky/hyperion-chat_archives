#pragma once

#include <QObject>
#include <QScopedPointer>
#include <QString>

QT_BEGIN_NAMESPACE
class QSslSocket;
class QByteArray;
class QSslError;
class QAbstractSocket;
QT_END_NAMESPACE

class SecureSocketClient : public QObject
{
    Q_OBJECT

public:
    explicit SecureSocketClient(QObject *parent = nullptr);
    ~SecureSocketClient() override;

    void connectToServer(const QString &host, quint16 port);
    void setHwId(const QString &hwid);
    void sendTextMessage(const QString &message);
    void sendMedia(const QByteArray &mediaBuffer);

signals:
    void messageReceived(const QString &message);
    void connected();
    void errorOccurred(const QString &error);

private slots:
    void onReadyRead();
    void onConnected();
    void onSslErrors(const QList<QSslError> &errors);
    void onErrorOccurred(QAbstractSocket::SocketError socketError);

private:
    void sendHandshake();

    QScopedPointer<QSslSocket> socket;
    QString clientHwId;
    bool authenticated = false;
};
