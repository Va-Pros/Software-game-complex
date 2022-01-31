import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

ColumnLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true

    function saveQuestion() {
        const answers = EditorUtils.mapModel(answerModel, item => item.variant);
        const rightIndex = EditorUtils.findIndexInModel(answerModel, item => item.isRightAnswer);
        QuestionSaver.saveSingleChoiceQuestion(input.getText(), answers, rightIndex);
    }

    RegularQuestionInput {
        id: input
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }

    Controls.ButtonGroup {
        id: answerRadioGroup
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
            deleteVisible: !isRightAnswer
            Controls.RadioButton {
                Controls.ButtonGroup.group: answerRadioGroup
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
