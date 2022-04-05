import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
//import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"
    property int questionType: 2

    // override BaseQuestionEditor
    function saveQuestion(theme, difficulty) {
        const answers = getVariants()
        const correct = []
        for (let i = 0; i < answers.length; ++i) {
            correct.push(true)
        }

        const updatedId = database.insertORUpdateIntoQuestionTable(questionId, theme, difficulty, getQuestionText(), questionType, [answers], [correct], false)
        if (updatedId < 0) {
            console.log("error")
        } else {
            questionId = updatedId
        }
        //QuestionSaver.saveTypeInQuestion(theme, difficulty, isActive, getQuestionText(), getVariants());
    }
}
