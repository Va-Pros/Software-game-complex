import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: matchArea
    property string title: qsTr("Match area")
    property var variants: []
    property var answer:[]
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right

        Label {
            id: area
            font.pixelSize: 20
        }

        Repeater {
            id: ansField
            model: []

            RowLayout{
                Label {
                    text: modelData
                    font.pixelSize: 20
                }

                Label {
                    text: " - "
                    font.pixelSize: 20
                }

                ComboBox {
                    Layout.fillWidth: true
                    id: ansCombo
                    editable: false
                    model: matchArea.variants
                    font.pixelSize: 20
                    currentIndex: index
                    onCurrentIndexChanged:{
                        answer[index]=matchArea.variants[currentIndex];
                    }

                    onModelChanged: {
                        currentIndex = Math.min(index, model.length - 1)
                    }
                }
            }
        }
    }

    function init(data) {
        //console.log(data);
        ansField.model = data[5][0];
        for(var i=0;i<data[5][0].length;i++)
            answer.push(data[5][0][0]);
        matchArea.variants = data[5][1];
        area.text = `${data[3]}`;
    }
}
