import QtQuick 2.7
import QtQuick.Controls 2.3

Rectangle {
    id: root
    color: "black"
    anchors.fill: parent

    Text {
        id: player1Score
        text: "00"
        color: "white"
        anchors.top: parent.top
        anchors.left: parent.left
        font.family: pixelFontLoader.name
        font.pixelSize: 40

        property int score: 0
        function increaseScore() {
            score += 1
            text = score < 10 ? "0" + score : score
        }
    }

    Text {
        id: player2Score
        text: "00"
        color: "white"
        anchors.top: parent.top
        anchors.right: parent.right
        font.family: pixelFontLoader.name
        font.pixelSize: 40

        property int score: 0
        function increaseScore() {
            score += 1
            text = score < 10 ? "0" + score : score
        }
    }

    Item {
        z: 100000
        focus: true
        anchors.fill: parent

        Keys.onPressed: {
            switch(event.key) {
                case Qt.Key_Up: {
                    moveDelta(player1, -5)
                    break;
                }
                case Qt.Key_Down: {
                    moveDelta(player1, 5)
                    break;
                }
            }
        }
    }

    Rectangle {
        id: player1
        color: "white"
        width: 10
        height: 50
        y: (root.height - height) / 2
        anchors.left: parent.left
        anchors.margins: 4
    }

    Rectangle {
        id: player2
        color: "white"
        width: 10
        height: 50
        anchors.right: parent.right
        anchors.margins: 4

        y: { // You'll never win :P
            //(root.height - height) / 2
            return calculateCenter(rect).y - height / 2 - 25 * (calculateCenter(rect).y - root.height / 2) / (root.height / 2)
        }
    }


    Rectangle {
        id: rect
        width: 9
        height: width
        color: "white"
        x: (root.width - width) / 2
        y: (root.height - height) / 2

        property point direction: {
            return Qt.point(-1, 0)
        }
    }

    transitions: Transition {
        AnchorAnimation { duration: 500 }
    }

    function moveDelta(player, delta) {
        if (player.y + delta < 0) {
            player.y = 0
            return
        }
        if (player.y + delta > root.height - player.height) {
            player.y = root.height - player.height
            return
        }

        player.y += delta
    }

    function reset(item) {
        item.x = (root.width - item.width) / 2
        item.y = (root.height - item.height) / 2
        item.direction = Qt.point(-1, 0)
    }

    function calculateCenter(item) {
        return Qt.point(item.width / 2 + item.x, item.height / 2 + item.y)
    }

    function calculateHitVector(first, second) {
        // We calculate the radius only based in width
        // since the game is mostly horizontal
        var firstRadius = first.width / 2
        var secondRadius = first.width / 2

        // Vertical collision detection
        if(first.y < second.y + second.height
            && first.y + first.height > second.y) {
            // Horizontal collision detection
            if(first.x + first.width >= second.x
                && first.x <= second.x + second.width) {
                rect.direction.x *= -1.1
                rect.direction.x = rect.direction.x > 8 ? 8 : rect.direction.x

                var vector1 = calculateCenter(first)
                var vector2 = calculateCenter(second)
                var vector = Qt.point(vector1.x - vector2.x, vector1.y - vector2.y)
                var tan = Math.atan2(vector.x, vector.y)
                rect.direction.y = -Math.cos(tan)
            }
        }
    }

    function calculateWallHitVector(item) {
        if(item.y <= 0 || item.y + item.height >= root.height) {
            rect.direction.y *= -1
        }

        if(item.x > root.width) {
            player1Score.increaseScore()
            reset(rect)
        }

        if(item.x + item.width < 0) {
            player2Score.increaseScore()
            reset(rect)
        }
    }

    // 60Hz engine
    Timer {
        running: true; repeat: true; interval: 1000/60
        onTriggered: {
            calculateWallHitVector(rect)
            calculateHitVector(player1, rect)
            calculateHitVector(player2, rect)
            rect.x += rect.direction.x
            rect.y += rect.direction.y
        }
    }

    FontLoader {
        id: pixelFontLoader
        source: "https://patrickelectric.work/qmlonline/resources/FreePixel.ttf"
    }
}
