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
    Layout.alignment: Qt.AlignTop

    function saveQuestion() {
        const answers = EditorUtils.mapModel(answerModel, item => item.variant);
        QuestionSaver.saveTypeInQuestion(input.getText(), answers);
    }

    RegularQuestionInput {
        id: input
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }

    ListModel {
        id: answerModel
        ListElement { variant: "" }
    }

    Component {
        id: answerDelegate
        AnswerInput {}
    }

    Controls.Button {
        Layout.fillWidth: true
        text: qsTr("Add answer variant")
        onClicked: {
            answerModel.append({variant: ""})
        }
    }

    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        id: answerListView
        model: answerModel
        delegate: answerDelegate
        clip: true
        Controls.ScrollBar.vertical: Controls.ScrollBar {}
    }

}
