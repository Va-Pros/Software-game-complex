import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

ColumnLayout {
    id: questionRoot
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var dataItemCreator: function(isFirstElement) { return { variant: "" } }

    required property int questionType
    required property var answerQmlFileName
    property var answerComponentProperties: (index) => ({})

    // these functions are passed from QuestionEditorPage
    required property var showInfo
    required property var showError
    required property var showSuccess
    required property var removeMessage

    property int questionId: -1

    function getQuestionText() {
        return input.getText()
    }

    function getAnswerModel() {
        return totalModel;
    }

    function getInputLayout() {
        return inputLayout;
    }

    function baseLoadQuestion(questionModel) {
        questionId = questionModel.id
        input.setText(questionModel.description)
    }

    function getCorrectnessArray() {
        throw "AbstractFunction"
    }

    function getSaveVariants() {
        throw "AbstractFunction"
    }

    function saveQuestion(theme, difficulty, isDelete) {
        const updatedId = admin.database.insertORUpdateIntoQuestionTable(questionId, theme, difficulty, getQuestionText(), questionType, getSaveVariants(), getCorrectnessArray(), isDelete)
        if (updatedId < 0) {
            console.log("error")
        } else {
            questionId = updatedId
        }
    }

    ColumnLayout {
        id: inputLayout
        Layout.fillWidth: true

        RegularQuestionInput {
            id: input
            Layout.fillWidth: true
        }
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }
}
