#include "webbridge.h"
#include "mainwindow.h"

WebBridge::WebBridge(MainWindow *owner, QObject *parent)
    : QObject(parent)
    , m_owner(owner)
{
}

void WebBridge::sendMessage(const QString &message)
{
    if (m_owner) {
        m_owner->handleWebSendMessage(message);
    }
}

void WebBridge::uploadMedia()
{
    if (m_owner) {
        m_owner->handleWebUploadMedia();
    }
}

void WebBridge::editProfile()
{
    if (m_owner) {
        m_owner->onEditProfile();
    }
}

void WebBridge::requestInitialState()
{
    if (m_owner) {
        emit initialState(m_owner->currentNickname, m_owner->currentStatus, m_owner->currentOnline);
    }
}

void WebBridge::setTheme(const QString &theme)
{
    if (m_owner) {
        m_owner->applyTheme(theme);
        emit updateProfile(m_owner->currentNickname, m_owner->currentStatus, m_owner->currentOnline);
    }
}
