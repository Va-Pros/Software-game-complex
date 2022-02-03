import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {
    id: typeInRoot
    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }

    Controls.ButtonGroup {
        id: answerRadioGroup
    }

    answerQmlFileName: "AnswerWidgets/SingleChoiceAnswerInput.qml"
    answerComponentProperties: ({ buttonGroup: answerRadioGroup})

    function saveQuestion() {
        const rightIndex = EditorUtils.findIndexInModel(typeInRoot.getAnswerModel(), item => item.isRightAnswer);
        QuestionSaver.saveSingleChoiceQuestion(typeInRoot.getQuestionText(), typeInRoot.getVariants(), rightIndex);
    }
}
