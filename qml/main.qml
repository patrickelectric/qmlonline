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

    menuBar: MenuBar {
        Menu {
            title: "Examples"
            Repeater {
                model: examples.examples
                MenuItem {
                    text: modelData.name
                    onTriggered: codeEdit.text = examples.getTextFromExample(text)
                }
            }
        }
        Menu {
            title: "Tools"
            MenuItem {
                text: "Share"
                onTriggered: {
                    // Waiting for CROS fix...
                    //request(Util.createSharedCode(codeEdit.text))
                    popup.show(Util.createSharedCode(codeEdit.text))

                }
            }
        }
    }

    function request(url) {
        var request = new XMLHttpRequest();
        print("https://tinyurl.com/api-create.php\?url\=" + url)
        request.open('GET', "https://tinyurl.com/api-create.php\?url\=" + url);
        request.send();
        request.onload = function() {
            if (request.status == 200) {
                popup.show(`${request.response}`)
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
            if(codeEdit.text == "") {
                codeEdit.text = requestDefault()
            }
        }
        function requestDefault() {
            return examples.getTextFromExample("Rotation Animator")
        }
    }

    SplitView {
        // Anchors and Layout are not working
        width: parent.width
        height: parent.height

        orientation: Qt.Horizontal

        ColumnLayout {
            id: pathLayout
            Layout.fillHeight: true
            Layout.minimumWidth: view.contentWidth
            ScrollView {
                id: view
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: codeEdit.contentWidth
                clip: true

                RowLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    ColumnLayout {
                        spacing: 0
                        Repeater {
                            model: codeEdit.lineCount
                            Layout.fillHeight: true
                            anchors.topMargin: codeEdit.topPadding
                            delegate: Text {
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignRight
                                text: index + 1
                                color: 'gray'
                                font.bold: codeEdit.cursorLineNumber - 1 == index
                                anchors.margins: 0
                            }
                        }
                    }
                    TextArea {
                        id: codeEdit
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        leftPadding: 4
                        selectByMouse: true
                        text: Util.sharedCode()
                        property var cursorLineNumber: 0
                        onTextChanged: updateItem()
                        onCursorPositionChanged: {
                            codeEdit.cursorLineNumber = codeEdit.text.substr(0, cursorPosition).split("\n").length
                        }

                        function updateItem() {
                            userParentItem.create(codeEdit.text)
                        }

                        Keys.onPressed: {
                            if (event.key == Qt.Key_Escape) {
                                codeEdit.focus = false
                                if(userParentItem.userItem) {
                                    userParentItem.userItem.focus = true
                                }
                            } else if (event.key == Qt.Key_Tab) {
                                // Tabs are an unholy thing
                                codeEdit.insert(cursorPosition, "    ");
                                event.accepted = true;
                            }
                        }

                        Rectangle {
                            color: "yellow"
                            width: codeEdit.width + codeEdit.x
                            height: codeEdit.cursorRectangle.height
                            visible: codeEdit.focus
                            opacity: 0.2
                            z: codeEdit.z -1
                            y: codeEdit.cursorRectangle.y
                            x: - codeEdit.x
                        }
                    }

                    SyntaxHighlighter {
                        id: syntaxHighlighter
                        textDocument: codeEdit.textDocument
                    }
                }
            }
            Button {
                id: codeEditButton
                Layout.fillWidth: true
                text: "Update!"
                onClicked: codeEdit.updateItem()
            }
        }

        Item {
            id: userParentItem
            Layout.fillHeight: true
            Layout.fillWidth: true
            property var userItem: null

            function create(textComponent) {
                if(userItem) {
                    userItem.destroy()
                }
                userItem = Qt.createQmlObject(textComponent, userParentItem, "userItem")
            }
        }
    }
}
