#pragma once

#include <QObject>

class MainWindow;

class WebBridge : public QObject
{
    Q_OBJECT

public:
    explicit WebBridge(MainWindow *owner, QObject *parent = nullptr);

    Q_INVOKABLE void sendMessage(const QString &message);
    Q_INVOKABLE void uploadMedia();
    Q_INVOKABLE void editProfile();
    Q_INVOKABLE void requestInitialState();
    Q_INVOKABLE void setTheme(const QString &theme);

signals:
    void appendLog(const QString &message);
    void updateProfile(const QString &nickname, const QString &status, bool online);
    void showError(const QString &message);
    void initialState(const QString &nickname, const QString &status, bool online);

private:
    MainWindow *m_owner;
};
