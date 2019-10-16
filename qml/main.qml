import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

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
            duration: 700
        }
    }
}`

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        SplitView.minimumWidth: codeEdit.contentWidth

        ColumnLayout {
            id: pathLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Flickable {
                id: flick
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumWidth: codeEdit.contentWidth
                clip: true

                function updateViewerPosition(cursorRectangle)
                {
                    if (contentX >= cursorRectangle.x) {
                        contentX = cursorRectangle.x
                    } else if (contentX + width <= cursorRectangle.x + cursorRectangle.width) {
                        contentX = cursorRectangle.x + cursorRectangle.width - width
                    } else if (contentY >= cursorRectangle.y) {
                        contentY = cursorRectangle.y
                    } else if (contentY + height <= cursorRectangle.y + cursorRectangle.height) {
                        contentY = cursorRectangle.y + cursorRectangle.height - height
                    }
                }

                TextArea {
                    id: codeEdit
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    focus: false
                    selectByMouse: true
                    text: exampleCode
                    onTextChanged: updateItem()
                    onCursorRectangleChanged: flick.updateViewerPosition(cursorRectangle)

                    function updateItem() {
                        userParentItem.create(codeEdit.text)
                    }

                    Keys.onPressed: {
                        if (event.key == Qt.Key_Escape) {
                            codeEdit.focus = false
                            if(userParentItem.userItem) {
                                userParentItem.userItem.focus = true
                            }
                        }
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
