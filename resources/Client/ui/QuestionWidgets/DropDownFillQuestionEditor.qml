import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

FillQuestionEditor {

    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }

    answerQmlFileName: "AnswerWidgets/SingleChoiceAnswerInput.qml"
    answerComponentProperties: (index) => {
        const group = repeater.itemAt(index).resources[0]
        return ({ buttonGroup: group})
    }

    // override FillQuestionEditor
    function saveFillQuestion(theme, difficulty, isActive, questionText, gapIndices, answerModels) {
        const variants = answerModels.map(qtModel => EditorUtils.mapModel(qtModel, item => item.variant));
        const rightAnswers = answerModels.map(qtModel => EditorUtils.findIndexInModel(qtModel, item => item.isRightAnswer));
        QuestionSaver.saveDropDownFillQuestion(questionText, gapIndices, variants, rightAnswers);
    }

    Repeater {
        id: repeater
        model: getAnswerModel() // don't use getAnswerModel().count bacuse it produces errors

        Item {
            Controls.ButtonGroup {}
        }
    }
}
