import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0

Kirigami.Page {
    id: editorRoot
    required property string questionType
    required property string widgetPath

    title: questionType

    function showError(text) {
        removeMessage()
        errorMessage.type = Kirigami.MessageType.Error
        showMessage(text)
    }

    function showSuccess(text) {
        removeMessage()
        errorMessage.type = Kirigami.MessageType.Positive
        showMessage(text)
    }

    function showInfo(text) {
        removeMessage()
        errorMessage.type = Kirigami.MessageType.Information
        showMessage(text)
    }

    function showMessage(text) {
        errorMessage.text = text
        errorMessage.visible = true
        errorMessageTimer.running = true
    }

    function removeMessage() {
        errorMessage.visible = false
        errorMessageTimer.running = false
    }

    QuestionThemes {
        id: themes
        onModelChanged: {
            const model = themes.getThemeModel();
            appendReceivedThemes(model)
        }
    }

    ColumnLayout {
        id: themeLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Kirigami.ActionToolBar {
            id: themeBar
            Layout.fillWidth: true

            flat: false
            actions: Kirigami.Action {
                id: themeAction
                text: newThemeAction.text

                Kirigami.Action {
                    id: newThemeAction
                    text: qsTr("New theme")
                    shortcut: "Ctrl+T"
                    onTriggered: {
                        themeAction.text = text
                        themeNameField.focus = true
                    }
                }
            }
        }
        Controls.TextField {
            id: themeNameField
            Layout.fillWidth: true
            placeholderText: qsTr("Theme name")
            visible: themeAction.text === newThemeAction.text
        }
    }


    ColumnLayout {
        id: editorStub
        anchors.top: themeLayout.bottom
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
        Layout.alignment: Qt.AlignJustify

        RowLayout {
            id: settingsRow
            Kirigami.ActionToolBar {
                id: toolBar
                flat: false
                actions: [
                    Kirigami.Action {

                        id: difficultyAction
                        text: easyDifficultyAction.text

                        // TODO maybe get difficulty types from Cpp?
                        Kirigami.Action {
                            id: easyDifficultyAction
                            text: qsTr("Easy")
                            shortcut: "Ctrl+Shift+E"
                            onTriggered: difficultyAction.text = text
                        }
                        Kirigami.Action {
                            id: mediumDifficultyAction
                            shortcut: "Ctrl+Shift+M"
                            text: qsTr("Medium")
                            onTriggered: difficultyAction.text = text
                        }
                        Kirigami.Action {
                            id: hardDifficultyAction
                            shortcut: "Ctrl+Shift+H"
                            text: qsTr("Hard")
                            onTriggered: difficultyAction.text = text
                        }
                    },
                    Kirigami.Action {

                        Component {
                            id: switchComponent
                            Controls.Switch {
//                                id: activeSwitch
                                checked: true
                                text: checked ? qsTr("Active") : qsTr("Inactive")
                            }
                        }

                        shortcut: "Ctrl+Shift+A"
                        displayComponent: switchComponent
                        onTriggered: getActiveSwitch().toggle()
                    }
                ]

            }
        }

        Controls.Button {
            Layout.alignment: Qt.AlignRight
            text: "Save"
            icon.name: "document-save"
            onClicked: save()
        }

        Controls.Action {
            shortcut: StandardKey.Save
            onTriggered: save()
        }
    }

    Connections {
        target: QuestionSaver
        function onQuestionSaved() {
            showSuccess(qsTr("Saved!"))
        }
        function onSaveFailed(message) {
            showError(message)
        }
    }

    Component {
        id: dynamicAction
        Kirigami.Action {
            required property string title
            text: title
            onTriggered: themeAction.text = text
        }
    }

    // TODO rework; referencing 'activeSwitch' not works
    function getActiveSwitch() {
        return toolBar.children[0].children[2]
    }

    function save() {
        const theme = themeAction.text === newThemeAction.text ? themeNameField.text : themeAction.text
        let difficulty = QuestionDifficulty.EASY
        if (difficultyAction.text === mediumDifficultyAction.text) {
            difficulty = QuestionDifficulty.MEDIUM
        } else if (difficultyAction.text === hardDifficultyAction.text) {
            difficulty = QuestionDifficulty.HARD
        }

        showInfo(qsTr("Saving.."))
        try {
            editorStub.children[0].saveQuestion(theme, difficulty, getActiveSwitch().checked)
        } catch(e) {
            showError(qsTr("Unhandled error while saving: %1").arg(e))
        }
    }

    function appendReceivedThemes(themeModel) {
        console.log("AAAAAAAAAAAAAAAAA");
        for (let i = 0; i < themeModel.count(); ++i) {
            const theme = themeModel.getTheme(i);
            const title = theme.title;
            const obj = dynamicAction.createObject(themeAction, {title})
            themeAction.children.push(obj)
        }
    }

    function finishCreation(comp, compParent) {
        if (comp.status === Component.Ready) {
            comp.createObject(compParent, { showError, showSuccess, showInfo, removeMessage, });
        } else if (comp.status === Component.Error) {
            console.log("Error loading component:", comp.errorString());
        }
        console.log(QuestionDifficulty.MEDIUM)
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
