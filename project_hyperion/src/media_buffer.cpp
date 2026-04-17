#include "media_buffer.h"
#include <QFile>
#include <QFileInfo>
#include <cstring>

QByteArray MediaBufferManager::loadFileToBuffer(const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        return {};
    }

    QByteArray buffer = file.readAll();
    file.close();

    if (buffer.isEmpty() || QFileInfo(path).size() == 0) {
        clearBuffer(buffer);
        return {};
    }

    return buffer;
}

void MediaBufferManager::clearBuffer(QByteArray &buffer)
{
    if (buffer.isEmpty()) {
        return;
    }
    std::memset(buffer.data(), 0, static_cast<size_t>(buffer.size()));
    buffer.clear();
    buffer.squeeze();
}
