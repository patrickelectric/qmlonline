import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

import QtQml.Models 2.12

import Qt.labs.calendar 1.0

import Util 1.0

ApplicationWindow {
    id: window
    title: "qmlonline"
    visible: true

    Connections {
        target: Util
        onCodeChanged: userParentItem.create(Util.code)
    }

    Item {
        id: userParentItem
        anchors.fill: parent
        property var userItem: null

        function create(textComponent) {
            if(userItem) {
                userItem.destroy()
            }
            userItem = Qt.createQmlObject(textComponent, userParentItem, "userItem")
        }

        Component.onCompleted: userParentItem.create(Util.code)
    }
}
