import QtQuick 2.13
import QtQuick.Controls 2.5

Item {
    id: root
    anchors.fill: parent
    focus: true

    MouseArea {
        id: globalMouse
        hoverEnabled: true
        anchors.fill: parent
    }

    ListModel {
        id: listModel
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        property var path: listModel

        function getArea() {
            // Shoelace algorithm
            // Ref: https://en.wikipedia.org/wiki/Shoelace_formula
            var sum = 0

            for(var i = 0; i < path.count; i++) {
                var point = path.get(i)
                var nextPoint = i + 1 != path.count ? path.get(i + 1) : path.get(0)

                sum += point.xPos*nextPoint.yPos - nextPoint.xPos*point.yPos
            }

            return Math.abs(sum) / 2
        }

        function getCentroid() {
            // Calculate the centroid of a non-self-intersecting closed polygon defined by n vertices
            // Ref: https://en.wikipedia.org/wiki/Centroid
            var areaMultiplied = 6*getArea()
            var centroid = {xPos: 0, yPos: 0}

            for(var i = 0; i < path.count; i++) {
                var point = path.get(i)
                var nextPoint = i + 1 != path.count ? path.get(i + 1) : path.get(0)

                var multiplier = point.xPos*nextPoint.yPos - nextPoint.xPos*point.yPos
                centroid.xPos += (point.xPos + nextPoint.xPos)*multiplier
                centroid.yPos += (point.yPos + nextPoint.yPos)*multiplier
            }

            centroid.xPos = Math.abs(centroid.xPos/areaMultiplied)
            centroid.yPos = Math.abs(centroid.yPos/areaMultiplied)
            return centroid
        }

        onPaint: {
            var context = getContext("2d");
            context.reset();

            // Do not paint if there isn't enough points to create a line
            if(path.count < 2){
                return;
            }

            var firstPoint = path.get(0)
            context.beginPath()
            context.moveTo(firstPoint.xPos, firstPoint.yPos)
            context.lineWidth = 2
            context.strokeStyle = "red"
            context.textAlign = "center"

            for(var i = 1; i < path.count; i++) {
                // Create line with 2 points
                var previousPoint = path.get(i - 1)
                var point = path.get(i)

                // Calculate line middle point
                var middlePoint = {xPos: (point.xPos + previousPoint.xPos)/2, yPos: (point.yPos + previousPoint.yPos)/2}
                // Translated line to the origin
                var translatedLine = {xPos: point.xPos - previousPoint.xPos, yPos: point.yPos - previousPoint.yPos}
                // Calculate relative distance between the line points
                var relativeDistance = Math.hypot(translatedLine.yPos, translatedLine.xPos)
                // Calculate line angle
                var angle = Math.atan(translatedLine.yPos/translatedLine.xPos)

                // Translate and rotate context to draw distance text
                context.save();
                context.translate(middlePoint.xPos, middlePoint.yPos);
                context.rotate(angle);
                context.fillStyle = "blue"
                context.fillText(relativeDistance.toFixed(2), 0, -5);
                // Restore from translation and rotation
                context.restore()

                // Draw line to the next point
                context.lineTo(point.xPos, point.yPos)
            }

            // If there is enough points to create a polygon, fill it and add area information
            if(path.count > 2) {
                var centerPoint = getCentroid()
                context.fillStyle = "green"
                context.fillText(getArea().toFixed(2), centerPoint.xPos, centerPoint.yPos)
                context.fillStyle = "#22000033"
                context.fill()
            }
            context.stroke()
        }
    }

    Repeater {
        id: repeater
        model: canvas.path
        delegate: Rectangle {
            width: 10
            height: width
            color: "black"
            radius: width
            x: xPos - width/2
            y: yPos - height/2
            MouseArea {
                anchors.fill: parent
                drag.target: parent
                onPositionChanged: {
                    canvas.path.get(index).xPos = parent.x + width/2
                    canvas.path.get(index).yPos = parent.y + height/2
                    canvas.requestPaint()
                }
            }
        }
    }

    Keys.onPressed: {
        switch(event.key) {
            case Qt.Key_N:
                var newPoint = {xPos: globalMouse.mouseX, yPos: globalMouse.mouseY}
                print("New point:", JSON.stringify(newPoint))
                event.accepted = true

                canvas.path.append({xPos: globalMouse.mouseX, yPos: globalMouse.mouseY})
                canvas.requestPaint()
                break;

            case Qt.Key_D:
                var lastIndex = canvas.path.count - 1
                print("Delete last point:", JSON.stringify(canvas.path.get(lastIndex)))
                event.accepted = true

                canvas.path.remove(lastIndex, 1)
                canvas.requestPaint()
                break;

            default:
                print("We don't handle it.")
                event.accepted = false
        }
    }

    Label {
        anchors.top: parent.top
        text: "New Point: 'N', Delete Point: 'D'"
        font.pixelSize: 30
    }
}
