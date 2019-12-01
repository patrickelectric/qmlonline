import QtQuick 2.7
import QtQuick.Controls 2.3

Rectangle {
    color: "red"
    anchors.fill: parent

    ShaderEffect {
        id: shader
        Image {
            id: profilePic
            source: "https://farm8.staticflickr.com/7861/46451042134_cb4cefce18_b.jpg"
            visible: false
        }
        property var src: profilePic
        property var numberOfPixels: 10
        width: 400
        height: width
        anchors.centerIn: parent

        Timer {
            interval: 120; running: true; repeat: true
            onTriggered: parent.numberOfPixels = parent.numberOfPixels < 500 ?
                parent.numberOfPixels + 10 : 10
        }

        vertexShader: "
            uniform highp mat4 qt_Matrix;
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            varying highp vec2 coord;
            void main() {
                coord = qt_MultiTexCoord0;
                gl_Position = qt_Matrix * qt_Vertex;
            }
        "
        fragmentShader: "
            #ifdef GL_ES
                precision mediump float;
            #endif

            varying highp vec2 coord;
            uniform sampler2D src;
            uniform lowp float qt_Opacity;
            uniform int numberOfPixels;

            void main() {
                // We use scale and floor to perform an round method with n precision
                float scale = float(numberOfPixels);
                gl_FragColor = texture2D(src, floor(coord*scale)/scale)*qt_Opacity;
            }
        "
    }
}
