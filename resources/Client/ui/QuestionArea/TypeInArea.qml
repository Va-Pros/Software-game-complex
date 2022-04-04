import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: typeInArea
    property string title: qsTr("Type in area")
    property var answer:[null]
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right

        Label {
            id: area
            font.pixelSize: 20
        }
        TextField {
            id: answerField
            Layout.fillWidth: true
            font.pixelSize: 20
            placeholderText: qsTr("Type answer")
            onAccepted: startButton.clicked()
        }
    }

    function init(data) {
        area.text = `${data[3]}`;
    }
}
