import QtQuick.Controls 2.15 as Controls

AnswerInput {
    id: answerRoot
    required property var buttonGroup
    property bool isRightAnswer: false
    signal checkChanged(bool checked)

    deleteVisible: !isRightAnswer
    Controls.RadioButton {
        Controls.ButtonGroup.group: buttonGroup
        checked: isRightAnswer
        onCheckedChanged: answerRoot.checkChanged(checked);
    }
}
