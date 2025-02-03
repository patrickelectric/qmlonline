import QtQuick 2.7
import QtQuick.Layouts 1

GridLayout {
    id: root
    rows: 5
    columns: 5
    anchors.fill: parent
    columnSpacing: 0
    rowSpacing: 0

    Repeater {
        id: repeater
        model: parent.rows * parent.columns
        Rectangle {
            property var value: index / repeater.model
            color: Qt.hsva(value, value, value)
            width: root.width / root.columns
            height: root.height / root.rows
        }
    }
}
