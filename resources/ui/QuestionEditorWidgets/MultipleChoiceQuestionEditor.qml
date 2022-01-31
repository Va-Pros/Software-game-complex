import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import "." as QEW
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

ColumnLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true

    function saveQuestion() {
        const answers = EditorUtils.mapModel(answerModel, item => item.variant);
        const rightIndices = EditorUtils.findAllIndicesInModel(answerModel, item => item.isRightAnswer);
        QuestionSaver.saveMultipleChoiceQuestion(input.getText(), answers, rightIndices);
    }

    QEW.RegularQuestionInput {
        id: input
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }

    ListModel {
        id: answerModel
        ListElement {
            isRightAnswer: true
            variant: ""
        }
    }

    Component {
        id: answerDelegate
        AnswerInput {
            Controls.CheckBox {
                checked: isRightAnswer
                onCheckedChanged: isRightAnswer = checked;
            }
        }
    }

    Controls.Button {
        Layout.fillWidth: true
        text: qsTr("Add answer variant")
        onClicked: answerModel.append({isRightAnswer: false, variant: ""})
    }

    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        id: answerListView
        model: answerModel
        delegate: answerDelegate
        clip: true
        Controls.ScrollBar.vertical: Controls.ScrollBar {}
    }
}
