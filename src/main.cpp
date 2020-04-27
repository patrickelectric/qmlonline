#include <QApplication>
#include <QDebug>
#include <QQmlEngine>
#include <QQmlComponent>
#include "util.h"

#include <QtPlugin>

#include "3rdparty/kirigami/src/kirigamiplugin.h"

//Q_IMPORT_PLUGIN(KirigamiPlugin);

int main(int argc, char *argv[])
{
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication app(argc, argv);
    KirigamiPlugin::getInstance().registerTypes();
    QQmlEngine engine;
    QQmlComponent component(&engine);

        component.setData(
R"(
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true

    menuBar: MenuBar {

    }

    Button {
        z: 10000000
        text: "potato"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: print("potato")
    }
}
)"

            , {});
        component.create();

    qDebug() << "Component status:" << component.status();
        if (component.isError()) {
            qDebug() << "Error list:" << component.errors();
        }

    QObject::connect(Util::self(), &Util::codeChanged, [&component]() {
        qDebug() << "LOAD DATA!";
        component.setData(
R"(
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    focus: true

    menuBar: MenuBar {

    }

    Button {
        z: 10000000
        text: "potato"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: print("potato")
    }
}
)"

            , {});
        component.create();
        qDebug() << "LOADED DATA!";
    });

    while(true) {
        app.exec();
        qDebug() << "spin!";
    }
    return 0;
}
