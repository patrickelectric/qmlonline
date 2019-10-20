#pragma once

#include <QObject>

class Examples : public QObject
{
    Q_OBJECT
public:
    Examples(QObject* parent = nullptr);
};
