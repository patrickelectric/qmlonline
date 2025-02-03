import QtQuick 2.7
import QtQuick.Layouts 1

Rectangle {
    anchors.fill: parent
    color: "black"

    // 4Hz engine
    Timer {
        running: true; repeat: true; interval: 1000/4
        onTriggered: snake.update()
    }

    Item {
        id: snake
        z: -1
        property var initialBody: [Qt.point(2, 0), Qt.point(1, 0), Qt.point(0, 0)]
        property var body: initialBody
        property var direction: Qt.point(1, 0)
        property var command: "right"

        function update(where) {
            if(!where) {
                where = command
            } else {
                command = where
            }

            switch(where) {
                case "up": {
                    // There is no reverse direction
                    if (direction.y != 1) {
                        direction.x = 0;
                        direction.y = -1;
                    }
                    break
                }
                case "down": {
                    if (direction.y != -1) {
                        direction.x = 0;
                        direction.y = 1;
                    }
                    break
                }
                case "right": {
                    if (direction.x != -1) {
                        direction.x = 1;
                        direction.y = 0;
                    }
                    break
                }
                case "left": {
                    if (direction.x != 1) {
                        direction.x = -1;
                        direction.y = 0;
                    }
                    break
                }
            }
            move()
        }

        function checkCollision(array) {
            for(var i = 0; i < array.length; i++) {
                for(var u = i + 1; u < array.length; u++) {
                    if(array[i].x == array[u].x && array[i].y == array[u].y) {
                        return true
                    }
                }
            }

            return false
        }

        function move() {
            var head = snake.body[0]

            // Bend space to do jumps
            var newPoint = Qt.point(
                (head.x + direction.x) % grid.columns,
                (head.y + direction.y) % grid.rows
            )
            if(newPoint.x < 0) {
                newPoint.x += 10
            }
            if(newPoint.y < 0) {
                newPoint.y += 10
            }

            // Check if snake is eating apple
            if(newPoint.x != grid.food.x || newPoint.y != grid.food.y) {
                snake.body.pop()
            } else {
                grid.newFood();
            }
            snake.body.unshift(newPoint)

            // Check if we are hitting ourselfs
            if(checkCollision(snake.body)) {
                snake.body = [Qt.point(2, 0), Qt.point(1, 0), Qt.point(0, 0)]
            }

            repeater.reload()
        }

    }

    GridLayout {
        id: grid
        rows: 15
        columns: 15
        columnSpacing: 0
        rowSpacing: 0
        anchors.fill: parent

        readonly property int blockWidth: width / columns
        readonly property int blockHeight: height / rows

        property var food: newFood()
        function newFood() {
            // 0.1 is to help the food to be inside grid
            food = Qt.point(Math.floor(Math.random() * (columns - 0.1)), Math.floor(Math.random() * (rows - 0.1)))
            return food
        }

        Repeater {
            id: repeater
            model: parent.rows * parent.columns

            Rectangle {
                property var snakeBody: snake.body
                property var value: {
                    for(var local of snake.body) {
                        if(index == local.x  + local.y * grid.rows // Snake body
                            || index == grid.food.x + grid.food.y * grid.rows) { // food
                            return 1
                        }
                    }
                    return 0
                }
                color: Qt.rgba(value, value, value)

                Layout.fillWidth: true
                Layout.fillHeight: true

            }

            // Force model update
            function reload() {
                model = []
                model = parent.rows * parent.columns

            }
        }
    }

    // User input
    Item {
        z: 100000
        focus: true
        anchors.fill: parent

        Keys.onPressed: {
            switch(event.key) {
                case Qt.Key_Up: {
                    snake.command = "up"
                    break;
                }
                case Qt.Key_Down: {
                    snake.command = "down"
                    break;
                }
                case Qt.Key_Left: {
                    snake.command = "left"
                    break;
                }
                case Qt.Key_Right: {
                    snake.command = "right"
                    break;
                }
            }
        }
    }
}
