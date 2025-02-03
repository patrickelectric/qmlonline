import QtQuick 2.12

Rectangle {
    anchors.fill: parent

    AnimatedSprite {
        id: animation
        source: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuOYyu8ydKlI4UWwZb9WoOa7ThwgIMDz5rE1HmMe6OB21TViymmQ&s"
        anchors.centerIn: parent
        width: 60
        height: 60
        frameWidth: 46
        frameCount: 13
        frameDuration: 100
        reverse: false
        loops: 1
        onFinished: {
            reverse = !reverse
            running = true
        }
    }

     Image {
            source: animation.source
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
     }
}
