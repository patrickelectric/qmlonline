import QtQuick 2.14
import QtQml.Models 2.12

TextEdit {
    property var source: "https://raw.githubusercontent.com/patrickelectric/qmlonline/master/README.md"
    anchors.fill: parent
    textFormat: TextEdit.MarkdownText
    Component.onCompleted: getText(source, function(result) {
        text = result
    })

    function getText(url, callback) {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
                callback(xmlhttp.responseText)
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }
}
