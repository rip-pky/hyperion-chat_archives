#include "profiledialog.h"

#include <QCheckBox>
#include <QComboBox>
#include <QDialogButtonBox>
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QTextEdit>
#include <QVBoxLayout>

ProfileDialog::ProfileDialog(QWidget *parent)
    : QDialog(parent)
    , nicknameInput(new QLineEdit(this))
    , statusInput(new QTextEdit(this))
    , themeSelect(new QComboBox(this))
    , onlineToggle(new QCheckBox(tr("Mostrar como online"), this))
    , saveButton(new QPushButton(tr("Salvar"), this))
    , cancelButton(new QPushButton(tr("Cancelar"), this))
{
    setWindowTitle(tr("Configuração de Perfil"));
    setMinimumSize(420, 320);

    QLabel *nicknameLabel = new QLabel(tr("Apelido"), this);
    QLabel *statusLabel = new QLabel(tr("Status pessoal"), this);
    QLabel *themeLabel = new QLabel(tr("Tema do chat"), this);

    statusInput->setFixedHeight(120);
    statusInput->setPlaceholderText(tr("Escreva seu status de treino, partida ou disponibilidade..."));

    themeSelect->addItem(tr("Dark Gamer"), QStringLiteral("dark"));
    themeSelect->addItem(tr("Material Design 3"), QStringLiteral("md3"));
    themeSelect->addItem(tr("Stealth Console"), QStringLiteral("stealth"));

    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->addWidget(nicknameLabel);
    mainLayout->addWidget(nicknameInput);
    mainLayout->addWidget(statusLabel);
    mainLayout->addWidget(statusInput);
    mainLayout->addWidget(themeLabel);
    mainLayout->addWidget(themeSelect);
    mainLayout->addWidget(onlineToggle);

    QHBoxLayout *buttonLayout = new QHBoxLayout;
    buttonLayout->addStretch();
    buttonLayout->addWidget(cancelButton);
    buttonLayout->addWidget(saveButton);
    mainLayout->addLayout(buttonLayout);

    connect(saveButton, &QPushButton::clicked, this, &ProfileDialog::accept);
    connect(cancelButton, &QPushButton::clicked, this, &ProfileDialog::reject);
}

QString ProfileDialog::nickname() const
{
    return nicknameInput->text().trimmed();
}

QString ProfileDialog::status() const
{
    return statusInput->toPlainText().trimmed();
}

QString ProfileDialog::theme() const
{
    return themeSelect->currentData().toString();
}

bool ProfileDialog::showOnline() const
{
    return onlineToggle->isChecked();
}

void ProfileDialog::setNickname(const QString &nickname)
{
    nicknameInput->setText(nickname);
}

void ProfileDialog::setStatus(const QString &status)
{
    statusInput->setPlainText(status);
}

void ProfileDialog::setTheme(const QString &theme)
{
    int index = themeSelect->findData(theme);
    if (index >= 0) {
        themeSelect->setCurrentIndex(index);
    }
}

void ProfileDialog::setShowOnline(bool showOnline)
{
    onlineToggle->setChecked(showOnline);
}
