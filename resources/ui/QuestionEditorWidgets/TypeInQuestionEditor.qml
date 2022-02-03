import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

OneColumnAnswersQuestionEditor {
    id: typeInRoot

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"

    function saveQuestion() {
        QuestionSaver.saveTypeInQuestion(typeInRoot.getQuestionText(), typeInRoot.getVariants());
    }
}
