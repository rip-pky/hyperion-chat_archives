#include "hwid_utils.h"

#include <QCryptographicHash>
#include <QSysInfo>
#include <QStringList>

QString generateHwId()
{
    QStringList entropy;
    entropy << QSysInfo::machineHostName();
    entropy << QSysInfo::kernelType();
    entropy << QSysInfo::kernelVersion();
    entropy << QSysInfo::productType();
    entropy << QSysInfo::productVersion();
    entropy << QSysInfo::currentCpuArchitecture();

    const QByteArray raw = entropy.join("|").toUtf8();
    return QString::fromUtf8(QCryptographicHash::hash(raw, QCryptographicHash::Sha256).toHex());
}
