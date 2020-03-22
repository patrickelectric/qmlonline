import QtQuick 2.13
import QtQuick.Layouts 1.13

Item {
    id: root
    ColumnLayout {
        Repeater {
            model: 10
            Text {
                text: index
            }
        }
    }
}
