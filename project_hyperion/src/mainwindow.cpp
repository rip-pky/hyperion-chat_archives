#include "mainwindow.h"
#include "hwid_utils.h"
#include "md3_theme.h"
#include "profiledialog.h"
#include "errordialog.h"
#include "webbridge.h"

#include <QApplication>
#include <QFileDialog>
#include <QHBoxLayout>
#include <QWebChannel>
#include <QWebEngineView>
#include <QVBoxLayout>
#include <QDateTime>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , webView(new QWebEngineView(this))
    , webBridge(new WebBridge(this, this))
    , socketClient(std::make_unique<SecureSocketClient>(this))
    , currentNickname(tr("Convidado"))
    , currentStatus(tr("Disponível para jogar"))
    , currentTheme(QStringLiteral("md3"))
    , currentOnline(true)
{
    setupUi();
    applyTheme(currentTheme);
    updateProfileCard();

    connect(socketClient.get(), &SecureSocketClient::messageReceived, this, &MainWindow::onReceiveMessage);
    connect(socketClient.get(), &SecureSocketClient::connected, this, &MainWindow::onSocketConnected);
    connect(socketClient.get(), &SecureSocketClient::errorOccurred, this, &MainWindow::onSocketError);

    socketClient->setHwId(generateHwId());
    socketClient->connectToServer("127.0.0.1", 4433);
}

MainWindow::~MainWindow() = default;

void MainWindow::setupUi()
{
    QWidget *central = new QWidget(this);
    setCentralWidget(central);

    QVBoxLayout *layout = new QVBoxLayout(central);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(webView);

    auto channel = new QWebChannel(this);
    channel->registerObject(QStringLiteral("bridge"), webBridge);
    webView->page()->setWebChannel(channel);
    webView->load(QUrl(QStringLiteral("qrc:/ui/index.html")));
}

void MainWindow::appendLog(const QString &text)
{
    if (webBridge) {
        webBridge->appendLog(QString("[%1] %2").arg(QDateTime::currentDateTime().toString("hh:mm:ss"), text));
    }
}

void MainWindow::showErrorDialog(const QString &title, const QString &message)
{
    ErrorDialog dialog(title, message, this);
    dialog.exec();
    if (webBridge) {
        webBridge->showError(message);
    }
}

void MainWindow::updateProfileCard()
{
    if (webBridge) {
        webBridge->updateProfile(currentNickname, currentStatus, currentOnline);
    }
}

void MainWindow::applyTheme(const QString &theme)
{
    currentTheme = theme;
    if (theme == QLatin1String("md3")) {
        md3::applyMaterialDesign3Theme(*qApp);
        return;
    }

    QPalette palette;
    if (theme == QLatin1String("stealth")) {
        palette.setColor(QPalette::Window, QColor(10, 12, 16));
        palette.setColor(QPalette::WindowText, QColor(195, 205, 225));
        palette.setColor(QPalette::Base, QColor(6, 8, 12));
        palette.setColor(QPalette::AlternateBase, QColor(14, 18, 24));
        palette.setColor(QPalette::Text, QColor(200, 208, 234));
        palette.setColor(QPalette::Button, QColor(18, 22, 30));
        palette.setColor(QPalette::ButtonText, QColor(205, 215, 240));
        palette.setColor(QPalette::Highlight, QColor(61, 211, 176));
        palette.setColor(QPalette::HighlightedText, QColor(10, 12, 16));
        QApplication::setPalette(palette);
        setStyleSheet("QPushButton { background: #13181f; border: 1px solid #23304a; color: #d6ddf2; padding: 10px; border-radius: 10px; }"
                      "QPushButton:hover { background: #1c2634; }");
        return;
    }

    palette.setColor(QPalette::Window, QColor(18, 22, 30));
    palette.setColor(QPalette::WindowText, QColor(230, 230, 230));
    palette.setColor(QPalette::Base, QColor(12, 15, 22));
    palette.setColor(QPalette::AlternateBase, QColor(22, 28, 38));
    palette.setColor(QPalette::ToolTipBase, QColor(255, 255, 255));
    palette.setColor(QPalette::ToolTipText, QColor(255, 255, 255));
    palette.setColor(QPalette::Text, QColor(220, 220, 220));
    palette.setColor(QPalette::Button, QColor(33, 38, 52));
    palette.setColor(QPalette::ButtonText, QColor(230, 230, 230));
    palette.setColor(QPalette::Highlight, QColor(98, 110, 255));
    palette.setColor(QPalette::HighlightedText, QColor(255, 255, 255));
    QApplication::setPalette(palette);
    setStyleSheet("QPushButton { background: #2c3248; border: 1px solid #3d4562; padding: 8px; border-radius: 8px; color: #e8e8f0; }"
                  "QPushButton:hover { background: #3f4b71; }");
}

void MainWindow::handleWebSendMessage(const QString &message)
{
    if (message.trimmed().isEmpty()) {
        return;
    }
    socketClient->sendTextMessage(message);
    appendLog(tr("Você: %1").arg(message));
}

void MainWindow::handleWebUploadMedia()
{
    QString filePath = QFileDialog::getOpenFileName(this, tr("Enviar mídia"), QString(), tr("Imagens (*.png *.jpg *.jpeg);;Todos os arquivos (*)"));
    if (filePath.isEmpty()) {
        return;
    }

    QByteArray mediaData = mediaManager.loadFileToBuffer(filePath);
    if (mediaData.isEmpty()) {
        showErrorDialog(tr("Falha ao carregar mídia"), tr("Não foi possível carregar o arquivo em memória no buffer seguro."));
        return;
    }

    socketClient->sendMedia(mediaData);
    appendLog(tr("Mídia enviada em buffer seguro."));
    mediaManager.clearBuffer(mediaData);
}

void MainWindow::onEditProfile()
{
    ProfileDialog dialog(this);
    dialog.setNickname(currentNickname);
    dialog.setStatus(currentStatus);
    dialog.setTheme(currentTheme);
    dialog.setShowOnline(currentOnline);

    if (dialog.exec() == QDialog::Accepted) {
        currentNickname = dialog.nickname();
        currentStatus = dialog.status();
        currentOnline = dialog.showOnline();
        applyTheme(dialog.theme());
        updateProfileCard();
        appendLog(tr("Perfil atualizado: %1").arg(currentNickname));
    }
}

void MainWindow::onReceiveMessage(const QString &message)
{
    appendLog(tr("Servidor: %1").arg(message));
}

void MainWindow::onSocketConnected()
{
    appendLog(tr("Conectado ao servidor seguro."));
}

void MainWindow::onSocketError(const QString &error)
{
    appendLog(tr("Erro de socket: %1").arg(error));
    showErrorDialog(tr("Erro de conexão"), error);
}
