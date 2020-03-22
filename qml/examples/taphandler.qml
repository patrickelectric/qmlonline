import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Rectangle {
    id: root
    color: "pink"
    anchors.fill: parent
    property var msgs: []

    TapHandler {
        onTapped: newMsg("Left click!")
    }
    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: newMsg("Right click!")
    }

    function newMsg(msg) {
            console.log(msg)
            msgs.push(msg)
            // We need to force a *Changed* signal for normal js lists
            view.model = msgs
    }

    ListView {
        id: view
        height: parent.height
        delegate: Text {
            text: index + ": " + modelData
        }
    }
}
