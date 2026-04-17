#pragma once

#include <QDialog>

QT_BEGIN_NAMESPACE
class QLineEdit;
class QTextEdit;
class QComboBox;
class QCheckBox;
class QPushButton;
QT_END_NAMESPACE

class ProfileDialog : public QDialog
{
    Q_OBJECT

public:
    explicit ProfileDialog(QWidget *parent = nullptr);
    QString nickname() const;
    QString status() const;
    QString theme() const;
    bool showOnline() const;

    void setNickname(const QString &nickname);
    void setStatus(const QString &status);
    void setTheme(const QString &theme);
    void setShowOnline(bool showOnline);

private:
    QLineEdit *nicknameInput;
    QTextEdit *statusInput;
    QComboBox *themeSelect;
    QCheckBox *onlineToggle;
    QPushButton *saveButton;
    QPushButton *cancelButton;
};
