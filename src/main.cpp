#include <QApplication>
#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include "util.h"

#include <QtPlugin>

#include "3rdparty/kirigami/src/kirigamiplugin.h"

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication app(argc, argv);
    KirigamiPlugin::getInstance().registerTypes();
    QQmlEngine engine;
    QQmlComponent component(&engine);

    std::unique_ptr<QObject> componentPtr;
    QObject::connect(Util::self(), &Util::codeChanged, [&componentPtr, &component]() {
        qDebug() << "LOAD DATA!";
        qDebug() << Util::self()->code().toLatin1();
        component.setData(Util::self()->code().toLatin1(), {});
        componentPtr.reset(component.create());
        qDebug() << "Component status:" << component.status();
        if (component.isError()) {
            qDebug() << "Error list:" << component.errors();
        }
        qDebug() << "LOADED DATA!";
    });

    return app.exec();;
}
