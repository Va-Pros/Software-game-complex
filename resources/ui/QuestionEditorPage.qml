import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    id: editorRoot
    required property string questionType
    required property string widgetPath

    title: questionType

    function showError(text) {
        errorMessage.text = text
        errorMessage.visible = true
        errorMessageTimer.running = true
    }

    function removeErrorMessage() {
        errorMessage.visible = false
        errorMessageTimer.running = false
    }

    ColumnLayout {
        id: editorStub
        anchors.top: parent.top
        anchors.bottom: errorMessage.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Timer {
        id: errorMessageTimer
        interval: 10000; repeat: false
        onTriggered: errorMessage.visible = false
    }

    Kirigami.InlineMessage {
        id: errorMessage
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomRow.top
        type: Kirigami.MessageType.Error
    }

    RowLayout {
        id: bottomRow
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        layoutDirection: Qt.RightToLeft

        Controls.Button {
            text: "Save"
            icon.name: "document-save"
            onClicked: {
                editorStub.children[0].saveQuestion()
            }
        }
    }

    function finishCreation(comp, compParent) {
        if (comp.status === Component.Ready) {
            comp.createObject(compParent, {questionShowError: showError, questionRemoveError: removeErrorMessage});
        } else if (comp.status === Component.Error) {
            console.log("Error loading component:", comp.errorString());
        }
    }

    Component.onCompleted: {
        const questionEditor = Qt.createComponent(widgetPath, editorStub);
        if (questionEditor.status === Component.Loading) {
            questionEditor.statusChanged.connect(function() { finishCreation(questionEditor, editorStub); });
        } else {
            finishCreation(questionEditor, editorStub);
        }
    }
}
