#include <QApplication>
#include <QQmlApplicationEngine>

#include "util.h"
#include "version.h"

#include "3rdparty/kirigami/src/kirigamiplugin.h"

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    KirigamiPlugin::getInstance().registerTypes();

    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));
    return app.exec();
}
