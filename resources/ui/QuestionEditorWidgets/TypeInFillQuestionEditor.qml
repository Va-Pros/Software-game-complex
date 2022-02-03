import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils
import "AnswerWidgets"

ColumnLayout {
    id: questionRoot
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.alignment: Qt.AlignTop

    function saveQuestion() {

        var questionText = input.getText();
        const formatter = "{txt}";

        const gapIndices = [];
        var gapIndex = questionText.indexOf(formatter)
        while (gapIndex !== -1) {
            gapIndices.push(gapIndex);

            questionText = questionText.substring(0, gapIndex) + questionText.substring(gapIndex + formatter.length);
            gapIndex = questionText.indexOf(formatter)
        }

        const arrayOfQtModels = EditorUtils.mapModel(listOfListsModel, item => item.gapModel);
        const answers = arrayOfQtModels.map(qtModel => EditorUtils.mapModel(qtModel, item => item.variant));

        // TODO null && empty values validation
        if (gapIndices.length === answers.length) {
            QuestionSaver.saveTypeInFillQuestion(questionText, gapIndices, answers);
        } else {
            console.log("ERROR! gapsCount: " + gapIndices.length + "; answersListsCount: " + answers.length); // TODO show error to user
        }
    }

    RegularQuestionInput {
        id: input
    }

    Controls.Label {
        id: hintLabel
        text: qsTr("Input {txt} to spicify fill position. i'th entering of {txt} in text will use i'th variants list")
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }

    ListModel {
        id: listOfListsModel
        Component.onCompleted: {
            listOfListsModel.append({gapModel: [{variant: ""}]})
        }
    }

    Component {
        id: listOfListsDelegate
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Component {
                id: answerDelegate
                AnswerInput {
                    listModel: gapModel
                }
            }

            Controls.Button {
                Layout.fillWidth: true
                text: qsTr("Add answer variant")
                onClicked: {
                    gapModel.append({variant: ""})
                }
            }

            ListView {
                Layout.fillWidth: true
                implicitHeight: 50
                model: gapModel
                delegate: answerDelegate
                clip: true
                Controls.ScrollBar.vertical: Controls.ScrollBar {}
            }
        }
    }

    Controls.Button {
        Layout.fillWidth: true
        text: qsTr("Add list")
        onClicked: {
            listOfListsModel.append({gapModel: [{variant: ""}]})
        }
    }

    GridLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        id: listOfListsView
//        model: listOfListsModel
//        delegate: listOfListsDelegate
        clip: true
        columns: listOfListsModel.count < 4 ? listOfListsModel.count : 4
//        Controls.ScrollBar.vertical: Controls.ScrollBar {}

        Repeater {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: listOfListsModel
            delegate: listOfListsDelegate
        }

    }

    Rectangle {
        color: "red"
        implicitHeight: 50
        Layout.fillWidth: true
    }

}
