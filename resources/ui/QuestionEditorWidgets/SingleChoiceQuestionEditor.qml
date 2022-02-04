import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {

    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }
    answerQmlFileName: "AnswerWidgets/SingleChoiceAnswerInput.qml"
    answerComponentProperties: (index) => ({ buttonGroup: answerRadioGroup})

    // override BaseQuestionEditor
    function saveQuestion() {
        const rightIndex = EditorUtils.findIndexInModel(getAnswerModel(), item => item.isRightAnswer);
        QuestionSaver.saveSingleChoiceQuestion(getQuestionText(), getVariants(), rightIndex);
    }

    Controls.ButtonGroup {
        id: answerRadioGroup
    }
}
