import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

ColumnLayout {
    id: questionRoot
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var dataItemCreator: function(isFirstElement) { return { variant: "" } }

    required property var answerQmlFileName
    property var answerComponentProperties: (index) => ({})

    // these functions are passed from QuestionEditorPage
    required property var showInfo
    required property var showError
    required property var showSuccess
    required property var removeMessage

    function getQuestionText() {
        return input.getText()
    }

    function getAnswerModel() {
        return totalModel;
    }

    function getInputLayout() {
        return inputLayout;
    }

    function saveQuestion(theme, difficulty, isActive) {
        throw "AbstractFunction"
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
