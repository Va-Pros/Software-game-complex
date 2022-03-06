import QtQuick.Controls 2.15 as Controls

AnswerInput {
    id: answerRoot

    Controls.CheckBox {
        checked: isRightAnswer // 'isRightAnswer' provided automatically
        onCheckedChanged: isRightAnswer = checked;
    }
}
