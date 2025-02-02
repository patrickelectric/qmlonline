#include <QApplication>
#include <QQmlApplicationEngine>

#include "util.h"
#include "version.h"

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));
    return app.exec();
}
