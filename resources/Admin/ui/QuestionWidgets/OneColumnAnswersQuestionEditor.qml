import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

MultipleColumnsAnswersQuestionEditor {

    maxListCount: 1
    modifiable: false

    function getVariants() {
        return EditorUtils.mapModel(getAnswerModel(), item => item.variant);
    }

    function setAnswerModel(answerModel) {
        setTwoDimensionalModel(answerModel)
    }

    // override MultipleColumnsAnswersQuestionEditor
    function getArrayOfAnswerSubModels() {
        throw "unsupported"
    }

    // override MultipleColumnsAnswersQuestionEditor
    function getAnswerModel() {
        return getFirstSubModel();
    }

    function getSaveVariants() {
        return [getVariants()]
    }

    Controls.Action {
        shortcut: StandardKey.New
        onTriggered: getAnswerModel().append(dataItemCreator(false))
    }
}
