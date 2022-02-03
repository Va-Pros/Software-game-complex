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

    property var dataItemCreator: function(isFirstElement) { return { variant: "" } }

    required property var answerQmlFileName
    property var answerComponentProperties: ({})

    function getQuestionText() {
        return input.getText()
    }

    function getVariants() {
        return EditorUtils.mapModel(answerModel, item => item.variant);
    }

    function getAnswerModel() {
        return answerModel;
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
        Component.onCompleted: {
            answerModel.append(dataItemCreator(true))
        }
    }

    Component {
        id: answerDelegate
        Loader {
            property var parentList: answerListView

            Component.onCompleted: setSource(answerQmlFileName, answerComponentProperties)
        }
    }

    Controls.Button {
        Layout.fillWidth: true
        text: qsTr("Add answer variant")
        onClicked: answerModel.append(dataItemCreator(false))
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
