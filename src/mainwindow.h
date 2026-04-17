#pragma once

#include <QMainWindow>
#include <memory>

QT_BEGIN_NAMESPACE
class QWebEngineView;
class QWebChannel;
QT_END_NAMESPACE

#include "secure_socket_client.h"
#include "media_buffer.h"
#include "errordialog.h"

class WebBridge;

class MainWindow : public QMainWindow
{
    Q_OBJECT
    friend class WebBridge;

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow() override;

private slots:
    void onReceiveMessage(const QString &message);
    void onSocketConnected();
    void onSocketError(const QString &error);
    void onEditProfile();

private:
    void setupUi();
    void appendLog(const QString &text);
    void showErrorDialog(const QString &title, const QString &message);
    void updateProfileCard();
    void applyTheme(const QString &theme);

    void handleWebSendMessage(const QString &message);
    void handleWebUploadMedia();

    QWebEngineView *webView;
    WebBridge *webBridge;
    std::unique_ptr<SecureSocketClient> socketClient;
    MediaBufferManager mediaManager;

    QString currentNickname;
    QString currentStatus;
    QString currentTheme;
    bool currentOnline = true;
};
