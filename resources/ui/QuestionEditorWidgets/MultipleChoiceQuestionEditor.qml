import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {

    dataItemCreator: function(isFirstElement) { return { variant: "", isRightAnswer: isFirstElement } }

    answerQmlFileName: "AnswerWidgets/MultipleChoiceAnswerInput.qml"

    // override BaseQuestionEditor
    function saveQuestion() {
        const answerModel = getAnswerModel();
        const answers = EditorUtils.mapModel(answerModel, item => item.variant);
        const rightIndices = EditorUtils.findAllIndicesInModel(answerModel, item => item.isRightAnswer);
        QuestionSaver.saveMultipleChoiceQuestion(getQuestionText(), answers, rightIndices);
    }
}
