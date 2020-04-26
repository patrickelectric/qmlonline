#include <QApplication>
#include <QDebug>
#include <QQmlApplicationEngine>
#include "util.h"

#include <QtPlugin>

#include "3rdparty/kirigami/src/kirigamiplugin.h"

//Q_IMPORT_PLUGIN(KirigamiPlugin);

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication app(argc, argv);
    KirigamiPlugin::getInstance().registerTypes();
    QQmlApplicationEngine appEngine;

    QObject::connect(Util::self(), &Util::codeChanged, [&app, &appEngine]() {
        qDebug() << "LOAD DATA!";
        appEngine.loadData(Util::self()->code().toLatin1());
        qDebug() << "LOADED DATA!";
        app.quit();
    });

    while(true) {
        //appEngine.loadData( );
        qDebug() << "START APP!";
        app.exec();
        qDebug() << "END APP!";
    }

    return 0;
}
