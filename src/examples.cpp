#include "examples.h"

#include <QDebug>
#include <QDirIterator>

Examples::Examples(QObject* parent)
    : QObject(parent)
{
    QDirIterator iterator(":", QDirIterator::Subdirectories);
    while (iterator.hasNext()) {
        qDebug() << iterator.next();
    }
}
