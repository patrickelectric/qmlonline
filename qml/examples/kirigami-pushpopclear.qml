/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    globalDrawer: Kirigami.GlobalDrawer {
        title: "Hello App"
        titleIcon: "applications-graphics"

        actions: [
            Kirigami.Action {
                text: "push"
                onTriggered: pageStack.push(secondPageComponent)
            },
            Kirigami.Action {
                text: "pop"
                onTriggered: pageStack.pop()
            },
            Kirigami.Action {
                text: "clear"
                onTriggered: pageStack.clear()
            },
            Kirigami.Action {
                text: "replace"
                onTriggered: pageStack.replace(secondPageComponent)
            }
        ]
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent
        Kirigami.Page {
            title: "First Page"
            Rectangle {
                anchors.fill: parent
                Kirigami.Label {
                    text: "First Page"
                }
            }
        }
    }

    Component {
        id: secondPageComponent
        Kirigami.Page {
            title: "Second Page"
            Rectangle {
                color: "red"
                anchors.fill: parent
                Kirigami.Label {
                    text: "Second Page"
                }
            }
        }
    }

}
