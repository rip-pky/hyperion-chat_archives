#include "errordialog.h"

#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>

ErrorDialog::ErrorDialog(const QString &title, const QString &message, QWidget *parent)
    : QDialog(parent)
{
    setWindowTitle(title);
    setMinimumSize(380, 180);
    setModal(true);
    setWindowFlag(Qt::WindowContextHelpButtonHint, false);

    QLabel *label = new QLabel(message, this);
    label->setWordWrap(true);
    label->setStyleSheet("color: #f0f2ff; font-size: 13px; padding: 8px;");

    QPushButton *closeButton = new QPushButton(tr("Fechar"), this);
    closeButton->setCursor(Qt::PointingHandCursor);
    closeButton->setStyleSheet(
        "QPushButton { background: #3d4b8a; color: #f5f7ff; border-radius: 10px; padding: 10px 18px; }"
        "QPushButton:hover { background: #5b6ed2; }"
    );

    connect(closeButton, &QPushButton::clicked, this, &ErrorDialog::accept);

    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->addWidget(label);
    mainLayout->addStretch();
    mainLayout->addWidget(closeButton, 0, Qt::AlignRight);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    setStyleSheet("background: #141825; border: 1px solid #2c3a67; border-radius: 18px;");
}
