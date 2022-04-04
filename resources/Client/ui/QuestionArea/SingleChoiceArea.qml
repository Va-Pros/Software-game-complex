import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: typeInArea
    property string title: qsTr("Single choice area")
    property var answer:[null]
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right

        Label {
            id: area
            font.pixelSize: 20
        }
        Repeater {
            id:ansField
            model: []
            RadioButton {
                text:modelData
                font.pixelSize: 20
                onCheckedChanged: answer[0]=modelData;
            }
        }
    }

    function init(data) {
        ansField.model = data[5][0];
        area.text = `${data[3]}`;
    }
}
