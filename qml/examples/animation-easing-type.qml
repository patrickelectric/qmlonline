import QtQuick 2.13
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.13

RowLayout {
    anchors.fill: parent
    Repeater {
        model: [
            Easing.Linear,
            Easing.InQuad,
            Easing.OutQuad,
            Easing.InOutQuad,
            Easing.OutInQuad,
            Easing.InCubic,
            Easing.OutCubic,
            Easing.InOutCubic,
            Easing.InQuart,
            Easing.OutQuart,
            Easing.InExpo,
            Easing.OutCirc,
        ]

        Slider {
            orientation: Qt.Vertical
            Layout.fillHeight: true
            from: 0
            to: 1
            PropertyAnimation on value {
                duration: 3000
                from: 0
                to: 1.1
                loops: Animation.Infinite
                easing.type: modelData
            }
        }
    }
}