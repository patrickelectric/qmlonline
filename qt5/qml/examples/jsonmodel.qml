import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0

Item {
    id: root
    property var parameters: undefined

    anchors.fill: parent

    ScrollView {
        id: scroll

        height: parent.height

        ColumnLayout {
            id: parameterButton

            Repeater {
                model: root.parameters ? Object.keys(root.parameters['Sub']) : undefined

                Button {
                    text: modelData

                    Layout.fillWidth: true

                    onClicked: {
                        textContent.text = JSON.stringify(root.parameters['Sub'][modelData], null, 2)
                    }
                }
            }
        }
    }

    Text {
        id: textContent

        anchors.left: scroll.right
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    function getJson() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://jsonblob.com/api/jsonBlob/90eff412-2638-11ea-8b19-194c524ac128";

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
                root.parameters = JSON.parse(xmlhttp.responseText)
                progressBar.visible = false
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    ProgressBar {
        id: progressBar

        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        indeterminate: true

        Label {
            text: "loading..."

            font.pixelSize: 30

            anchors.margins: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            Layout.fillWidth: true
        }
    }

    Component.onCompleted: getJson()
}
