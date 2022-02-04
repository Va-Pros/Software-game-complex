import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils

MultipleColumnsAnswersQuestionEditor {

    maxListCount: 1
    modifiable: false

    function getVariants() {
        return EditorUtils.mapModel(getAnswerModel(), item => item.variant);
    }

    // override MultipleColumnsAnswersQuestionEditor
    function getArrayOfAnswerSubModels() {
        throw "unsupported"
    }

    // override MultipleColumnsAnswersQuestionEditor
    function getAnswerModel() {
        return getFirstSubModel();
    }
}
