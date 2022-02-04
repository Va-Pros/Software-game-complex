import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

MultipleColumnsAnswersQuestionEditor {

    inputFormatting: qsTr("Input {txt} to spicify fill position. i'th entering of {txt} in text will use i'th variants list")

    // override BaseQuestionEditor
    function saveQuestion() {
        var questionText = getQuestionText();
        const formatter = "{txt}";

        const gapIndices = [];
        var gapIndex = questionText.indexOf(formatter)
        while (gapIndex !== -1) {
            gapIndices.push(gapIndex);

            questionText = questionText.substring(0, gapIndex) + questionText.substring(gapIndex + formatter.length);
            gapIndex = questionText.indexOf(formatter)
        }

        const answerModels = getArrayOfAnswerSubModels()

        // TODO null && empty values validation
        if (gapIndices.length === answerModels.length) {
            saveFillQuestion(questionText, gapIndices, answerModels);
        } else {
            console.log("ERROR! gapsCount: " + gapIndices.length + "; answersListsCount: " + answerModels.length); // TODO show error to user
        }
    }

    function saveFillQuestion(questionText, gapIndices, answerModels) {
        throw "AbstractFunction"
    }
}
