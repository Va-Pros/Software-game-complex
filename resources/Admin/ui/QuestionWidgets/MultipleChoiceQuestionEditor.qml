import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {

    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }

    answerQmlFileName: "AnswerWidgets/MultipleChoiceAnswerInput.qml"
    questionType: 1

    function getCorrectnessArray() {
        return [EditorUtils.mapModel(getAnswerModel(), item => item.isRightAnswer)]
    }

//    function loadQuestion(questionModel) {
//        console.log("loadQuestion single:", questionModel.variant.length)
//        baseLoadQuestion(questionModel)

//        const items = []
//        for (let i = 0; i < questionModel.variant.length; ++i) {
//            items.push({variant: questionModel.variant[i], isRightAnswer: questionModel.correctness[i]})
//        }

//        setAnswerModel(items)
//    }
}
