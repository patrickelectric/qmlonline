import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1

Item {
    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        Slider {
            id: slider
            from: 0
            to: 100
            Layout.fillWidth: true

            Binding on value {
                when: spinBox.pressed
                value: spinBox.value
            }
            Binding on value {
                when: dial.pressed
                value: dial.value
            }
        }
        SpinBox {
            id: spinBox
            from: slider.from
            to: slider.to
            Layout.fillWidth: true

            Binding on value {
                when: slider.pressed
                value: slider.value
            }
            Binding on value {
                when: dial.pressed
                value: dial.value
            }
        }
        Dial {
            id: dial
            from: slider.from
            to: slider.to
            Layout.fillWidth: true

            Binding on value {
                when: slider.pressed
                value: slider.value
            }
            Binding on value {
                when: spinBox.pressed
                value: spinBox.value
            }
        }
    }
}
