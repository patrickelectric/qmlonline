import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    anchors.fill: parent

    Image {
        id: bug
        source: "https://live.staticflickr.com/2709/4163641325_8f60d4f75a_m.jpg"
        smooth: true
        visible: false
    }

    Image {
        id: butterfly
        source: "https://live.staticflickr.com/4154/5053150520_52bf707846_m.jpg"
        smooth: true
        visible: false
    }

    Blend {
        id: blend
        anchors.fill: parent
        source: bug
        foregroundSource: butterfly
        mode: "multiply"
    }

    ComboBox {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: [
            "normal",
            "addition",
            "average",
            "color",
            "colorBurn",
            "colorDodge",
            "darken",
            "darkerColor",
            "difference",
            "divide",
            "exclusion",
            "hardLight",
            "hue",
            "lighten",
            "lighterColor",
            "lightness",
            "multiply",
            "negation",
            "saturation",
            "screen",
            "subtract",
            "softLight",
        ]
        onCurrentTextChanged: blend.mode = currentText
    }
}
