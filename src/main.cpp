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
        //appEngine.loadData(Util::self()->code().toLatin1());
        qDebug() << "LOADED DATA!";

appEngine.loadData(
R"(
    import QtQuick 2.7
import QtQuick.Controls 2.3 as QQC2
import org.kde.kirigami 2.4 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    globalDrawer: Kirigami.GlobalDrawer {
        title: "Hello "
        titleIcon: "applications-graphics"

        actions: [
            Kirigami.Action {
                text: "View"
                iconName: "view-list-icons"
                Kirigami.Action {
                    text: "action 1"
                }
                Kirigami.Action {
                    text: "action 2"
                }
                Kirigami.Action {
                    text: "action 3"
                }
            },
            Kirigami.Action {
                text: "action 3"
            },
            Kirigami.Action {
                text: "action 4"
            }
        ]
    }
    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent
        Kirigami.ScrollablePage {
            title: "Hell"
            Rectangle {
                anchors.fill: parent
            }
        }
    }
}
)"
);



    });

    while(true) {
        //appEngine.loadData( );
        qDebug() << "START APP!";
        app.exec();
        qDebug() << "END APP!";
    }

    return 0;
}
