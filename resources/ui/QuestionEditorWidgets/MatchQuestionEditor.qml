import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils
import "AnswerWidgets"

ColumnLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true

    function saveQuestion() {
        const leftVarinats = EditorUtils.mapModel(leftColumnModel, item => item.variant);
        const rightVarinats = EditorUtils.mapModel(rightColumnModel, item => item.variant);
        QuestionSaver.saveMatchQuestion(input.getText(), leftVarinats, rightVarinats);
    }

    RegularQuestionInput {
        id: input
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }


    Component {
        id: columnDelegate

        AnswerInput {
            listModel: model
        }
    }

    ListModel {
        id: leftColumnModel
        Component.onCompleted: {
            append({variant: "", model: leftColumnModel})
        }
    }

    ListModel {
        id: rightColumnModel
        Component.onCompleted: {
            append({variant: "", model: rightColumnModel})
        }
    }

    RowLayout {
        id: scrollContainer
        Layout.fillWidth: true

        Controls.Button {
            Layout.fillWidth: true
            text: qsTr("Add answer variant")
            onClicked: leftColumnModel.append({variant: "", model: leftColumnModel})
        }

        Controls.Button {
            Layout.fillWidth: true
            text: qsTr("Add answer variant")
            onClicked: rightColumnModel.append({variant: "", model: rightColumnModel})
        }
    }

    RowLayout {
        Layout.fillWidth: true

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            id: leftColumnListView
            model: leftColumnModel
            delegate: columnDelegate
            clip: true
            Controls.ScrollBar.vertical: Controls.ScrollBar {}
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            id: rightColumnListView
            model: rightColumnModel
            delegate: columnDelegate
            clip: true
            Controls.ScrollBar.vertical: Controls.ScrollBar {}
        }

    }
}
