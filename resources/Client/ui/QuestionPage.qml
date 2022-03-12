import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    title: qsTr("Question Page")

    Controls.Label {
        text: qsTr("Question Page")
    }

    //Connections {
        ////target: client
        //function onNewMessage(ba) {
            //listModelMessages.append({message: ba + ""})
        //}
    //}

    ColumnLayout {
        anchors.fill: parent
        Controls.Label {
            id: question
            text: qsTr("Какого цвета форма в РФ?")
        }
        Controls.TextField {
            id: answerField
            Layout.fillWidth: true
            placeholderText: qsTr("Введите ответ")
            onAccepted: startButton.clicked()
        }
        RowLayout {
            Controls.Button {
                id: prevQuestion
                Layout.fillWidth: true
                text: qsTr("Назад")
                onClicked: {
                    console.log("save("+answerField.text+")");
                    console.log("Назад");
                    answerField.clear()
                }
            }
            Controls.Button {
                id: nextQuestion
                Layout.fillWidth: true
                text: qsTr("Дальше")
                onClicked: {
                    console.log("save("+answerField.text+")");
                    console.log("Дальше");
                    answerField.clear()
                }
            }
        }
    }
}
