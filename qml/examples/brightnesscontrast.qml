import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1

Item {
    anchors.fill: parent

    Image {
        id: bug
        source: "https://live.staticflickr.com/2709/4163641325_8f60d4f75a_m.jpg"
        smooth: true
        visible: false
    }

    BrightnessContrast {
        anchors.fill: parent
        source: bug
        brightness: sliderBright.value
        contrast: sliderContrast.value
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        RowLayout {
            Label {
                text: "Brightness [" + Math.round(sliderBright.value*100) + "]"
            }
            Slider {
                id: sliderBright
                Layout.fillWidth: true
            }
        }

        RowLayout {
            Label {
                text: "Contrast [" + Math.round(sliderContrast.value*100) + "]"
            }
            Slider {
                id: sliderContrast
                Layout.fillWidth: true
            }
        }
    }
}
