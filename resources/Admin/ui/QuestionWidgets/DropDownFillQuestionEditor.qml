import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

FillQuestionEditor {

    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }

    answerQmlFileName: "AnswerWidgets/SingleChoiceAnswerInput.qml"
    answerComponentProperties: (index) => {
        const group = repeater.itemAt(index).resources[0]
        return ({ buttonGroup: group})
    }

    questionType: 4

    function getCorrectnessArray() {
        const allModels = getArrayOfAnswerSubModels();
        return EditorUtils.mapModel(allModels, model => EditorUtils.mapModel(model, item => item.isRightAnswer))
    }

//    function loadQuestion(questionModel) {
//        baseLoadQuestion(questionModel)
//        loadTwoDimensionalAnswerModel(questionModel)
//    }

    Repeater {
        id: repeater
        model: getAnswerModel() // don't use getAnswerModel().count bacuse it produces errors

        Item {
            Controls.ButtonGroup {}
        }
    }
}
