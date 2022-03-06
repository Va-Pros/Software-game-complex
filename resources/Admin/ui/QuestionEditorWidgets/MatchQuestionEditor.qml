import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils
import "AnswerWidgets"

MultipleColumnsAnswersQuestionEditor {

    maxColumnCount: 2
    maxListCount: 2
    defaultListCount: 2
    modifiable: false

    answerQmlFileName: "AnswerWidgets/AnswerInput.qml"

    function saveQuestion(theme, difficulty, isActive) {
        const allModels = getArrayOfAnswerSubModels();
        const leftColumnModel = allModels[0];
        const rightColumnModel = allModels[1];
        const leftVarinats = EditorUtils.mapModel(leftColumnModel, item => item.variant);
        const rightVarinats = EditorUtils.mapModel(rightColumnModel, item => item.variant);
        QuestionSaver.saveMatchQuestion(theme, difficulty, isActive, getQuestionText(), leftVarinats, rightVarinats);
    }


}
