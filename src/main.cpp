#include "util.h"

#include <Qaterial/Qaterial.hpp>

#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:///");
    qaterial::Utils::loadResources();
    qaterial::Utils::registerTypes();

    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);
    engine.load(QUrl("qrc:/main.qml"));

    return app.exec();
}
