import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"

    // override BaseQuestionEditor
    function saveQuestion(theme, difficulty, isActive) {
        QuestionSaver.saveTypeInQuestion(theme, difficulty, isActive, getQuestionText(), getVariants());
    }
}
