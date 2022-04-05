import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: typeInArea
    property string title: qsTr("Type in fill area")
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
            placeholderText: qsTr("Type ans")
            onAccepted: startButton.clicked()
        }
    }

    function init(data) {
        area.text = `${data[3]}\n${data[5]}`;
    }
}