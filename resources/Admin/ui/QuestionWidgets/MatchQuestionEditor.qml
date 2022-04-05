import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils
import "AnswerWidgets"

MultipleColumnsAnswersQuestionEditor {

    maxColumnCount: 2
    maxListCount: 2
    defaultListCount: 2
    modifiable: false

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"

    questionType: 3

    function getCorrectnessArray() {
        const allModels = getArrayOfAnswerSubModels();
        return EditorUtils.mapModel(allModels, model => EditorUtils.mapModel(model, item => true))
    }

//    function loadQuestion(questionModel) {
//        baseLoadQuestion(questionModel)
//        const mapped = questionModel.variant.map(subarray => subarray.map(text => ({variant: text})))
//        setTwoDimensionalModel(mapped)
//    }
}
