import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

ColumnLayout {
    id: questionRoot
    Layout.fillWidth: true
    Layout.fillHeight: true

    property var dataItemCreator: function(isFirstElement) { return { variant: "" } }

    required property var answerQmlFileName
    property var answerComponentProperties: (index) => ({})

    // these two are passed from QuestionEditorPage
    required property var questionShowError
    required property var questionRemoveError

    function getQuestionText() {
        return input.getText()
    }

    function getAnswerModel() {
        return totalModel;
    }

    function getInputLayout() {
        return inputLayout;
    }

    function saveQuestion() {
        throw "AbstractFunction"
    }

    function showError(text) {
        questionShowError(text)
    }

    function removeErrorMessage() {
        questionRemoveError()
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

    Component.onCompleted: {
        console.log("err: ", bottomRow)
    }
}
