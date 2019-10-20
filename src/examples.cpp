#include "examples.h"

#include <QDebug>
#include <QDir>
#include <QTextStream>

Examples::Examples(QObject* parent)
    : QObject(parent)
{
    QDir dir(_basePath);
    dir.setFilter(QDir::Dirs | QDir::Files);
    for(const auto& file : dir.entryInfoList()) {
        auto fileName = file.fileName();
        _examples.append(QVariant::fromValue(Example{fileName.split('/').last().split('.').first(), fileName}));
    };
}

QString Examples::getTextFromExample(const QString& example) const
{
    QFile file(_basePath + example + ".qml");
    file.open(QIODevice::ReadOnly);
    QTextStream textStream(&file);
    return _header + textStream.readAll();
}
