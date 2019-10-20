import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

import SyntaxHighlighter 1.0

ApplicationWindow {
    id: window
    title: "qmlonline"
    visible: true

    property var exampleCode: `/* QML online!
 * Repository: https://github.com/patrickelectric/qmlonline
 *
 * You can check the offline/desktop version here **QHot!**:
 *     https://github.com/patrickelectric/qhot
 *
 * I'm working heavily and the web version is WIP,
 * be patient (and happy!), changes will be done soon.
 *
 */

// - Just edit the text or use the "Update!" button to update the Qml
// - Use your browser console to check the error/warning messages!
// - If something is not working, check if you are running the https version
import QtQuick 2.7
import QtQuick.Controls 2.3

Rectangle {
    color: "red"
    anchors.fill: parent

    Text {
        text: "WEEEEEEEEEE"
        font.pixelSize: 50
        color: "white"
        anchors.centerIn: parent
        RotationAnimator on rotation {
            running: true
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 1500
        }
    }
}`

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
                        text: exampleCode
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
