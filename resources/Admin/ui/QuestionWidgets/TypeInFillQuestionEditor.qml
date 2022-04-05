import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

FillQuestionEditor {

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"
    questionType: 5

    // override FillQuestionEditor
    function saveFillQuestion(theme, difficulty, isActive, questionText, gapIndices, answerModels) {
        const answers = answerModels.map(qtModel => EditorUtils.mapModel(qtModel, item => item.variant));
        QuestionSaver.saveTypeInFillQuestion(theme, difficulty, isActive, questionText, gapIndices, answers);
    }

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
