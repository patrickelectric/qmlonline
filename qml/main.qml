import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

import Examples 1.0
import Util 1.0
import SyntaxHighlighter 1.0

ApplicationWindow {
    id: window
    title: "qmlonline"
    visible: true

    /*
    menuBar: MenuBar {
        Menu {
            title: "Examples"
            Repeater {
                model: examples.examples
                MenuItem {
                    text: modelData.name
                    onTriggered: userParentItem.create(examples.getTextFromExample(text))
                }
            }
        }
        Menu {
            title: "Tools"
            MenuItem {
                text: "Share"
                onTriggered: {
                    request(Util.createSharedCode(codeEdit.text, true))
                    // Old method with raw links
                    //popup.show(Util.createSharedCode(codeEdit.text))
                }
            }
        }
    }

    function request(url) {
        var request = new XMLHttpRequest();
        Qt.openUrlExternally("https://tinyurl.com/api-create.php\?url\=" + url)

        request.open('GET', "https://tinyurl.com/api-create.php\?url\=" + url);
        request.send();
        request.onload = function() {
            if (request.status == 200) {
                print(`Get OK ${request.response}`)
                //popup.show(`${request.response}`)
            } else {
                print(`GET Error ${request.status}: ${request.statusText}`);
            }
        }
    }

    Popup {
        id: popup
        modal: true
        focus: true
        width: textEdit.width
        height: textEdit.height*3
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        TextEdit {
            id: textEdit
            anchors.centerIn: parent
            horizontalAlignment: TextEdit.AlignHCenter
            verticalAlignment: TextEdit.AlignVCenter
            readOnly: true
            width: window.width/2
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
        }
        function show(content) {
            textEdit.text = content
            textEdit.select(0, textEdit.text.length)
            popup.open()
            textEdit.copy()
        }

    }

    Examples {
        id: examples
        Component.onCompleted: {
            //userParentItem.create(requestDefault())
            userParentItem.create(Util.code)
        }
        function requestDefault() {
            return examples.getTextFromExample("Rotation Animator")
        }
    }*/

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
    }
}
