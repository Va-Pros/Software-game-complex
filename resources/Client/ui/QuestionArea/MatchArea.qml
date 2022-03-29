import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.4 as Kirigami
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
            id: titleQuestionArea
            font.italic: true
            font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
        }
        Label {
            id: area
        }

        Repeater {
            id: ansField
            model: []

            RowLayout{
                Label {
                    text: modelData
                }
                ComboBox {
                    Layout.fillWidth: true
                    id: ansCombo
                    editable: false
                    model: matchArea.variants
                    onCurrentIndexChanged:{
                        answer[index]=matchArea.variants[currentIndex];
                    }
                }
            }
        }
        RowLayout{
             Button {
                id: prevQuestion
                Layout.fillWidth: true
                text: qsTr("Prev")
                visible:questionEditorSwap.currentIndex>2
                onClicked: {
                    questionPage.saveAnswer(answer);
                    questionEditorSwap.currentIndex--;
                }
            }
            Button {
                id: nextQuestion
                Layout.fillWidth: true
                text: qsTr("Next")
                visible:questionEditorSwap.currentIndex<questionEditorSwap.length+1
                onClicked: {
                    questionPage.saveAnswer(answer);
                    questionEditorSwap.currentIndex++;
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
        titleQuestionArea.text=`${data[1]}  (+${1+Number(data[2])} point(s))`;
        area.text = `${data[3]}`;
    }
}
