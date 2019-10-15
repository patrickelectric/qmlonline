import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

ApplicationWindow {
    id: window
    title: "qmlonline"
    visible: true

    property var exampleCode: `/* QML online!
 * You can check the offline/desktop version here [QHot!]:
 *     https://github.com/patrickelectric/qhot
 *
 * I'm working heavily and the web version is WIP,
 * be patient (and happy!), changes will be done soon.
 *
 */

// - Use Ctrl+S or the "Update!" button update the Qml
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

        ColumnLayout {
            id: pathLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            TextEdit {
                id: pathEdit
                Layout.fillHeight: true
                Layout.fillWidth: true
                text: exampleCode
                onEditingFinished: updateItem()
                Component.onCompleted: updateItem()
                function updateItem() {
                    userParentItem.create(pathEdit.text)
                }

                Shortcut {
                    sequence: "Ctrl+S"
                    onActivated: pathEdit.updateItem()
                }
            }
            Button {
                id: pathEditButton
                Layout.fillWidth: true
                text: "ok!"
                onClicked: pathEdit.updateItem()
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
