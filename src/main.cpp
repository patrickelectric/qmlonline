#include <QApplication>
#include <QQmlApplicationEngine>
#include "util.h"

#include <QtPlugin>

#include "3rdparty/kirigami/src/kirigamiplugin.h"

//Q_IMPORT_PLUGIN(KirigamiPlugin);

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));

    KirigamiPlugin::getInstance().registerTypes();

    return app.exec();
}
