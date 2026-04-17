#pragma once

#include <QByteArray>
#include <QString>

class MediaBufferManager
{
public:
    MediaBufferManager() = default;
    ~MediaBufferManager() = default;

    QByteArray loadFileToBuffer(const QString &path);
    void clearBuffer(QByteArray &buffer);
};
