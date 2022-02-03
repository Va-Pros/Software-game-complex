import QtQuick.Controls 2.15 as Controls

AnswerInput {
    id: answerRoot
    required property var buttonGroup

    deleteVisible: !isRightAnswer
    Controls.RadioButton {
        Controls.ButtonGroup.group: buttonGroup
        checked: isRightAnswer // 'isRightAnswer' provided automatically
        onCheckedChanged: isRightAnswer = checked;
    }
}
