import QtQuick 2.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "black"

    Rectangle {
        id: rect
        width: 50
        height: 50
        color: "red"
        anchors.top: root.top
        anchors.left: root.left
        anchors.margins: 10
    }

    states: [
        State {
            name: "small"
            AnchorChanges {
                target: rect
                anchors.bottom: root.bottom
                anchors.right: root.right
            }
            PropertyChanges {
                target: rect
                height: 50
                width: 50
            }
        },
        State {
            name: "big"
            AnchorChanges {
                target: rect
                anchors.bottom: undefined
                anchors.right: undefined
            }
        }
    ]

    Timer {
        running: true; repeat: true; interval: 1000;
        onTriggered: root.state = root.state ===  "small" ?  "big" : "small"
    }

    transitions: Transition {
        AnchorAnimation { duration: 400 }
    }
}
