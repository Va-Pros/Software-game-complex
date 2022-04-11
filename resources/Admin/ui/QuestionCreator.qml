import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
//import QuestionCreator 1.0

Page {
    id: editorRoot
    required property string questionType
    required property string widgetPath

    title: questionType

    SplitView.fillWidth: true

    function showError(text) {
        //removeMessage()
        //errorMessage.type = Kirigami.MessageType.Error
        //showMessage(text)
    }

    function showSuccess(text) {
        //removeMessage()
        //errorMessage.type = Kirigami.MessageType.Positive
        //showMessage(text)
    }

    function showInfo(text) {
        //removeMessage()
        //errorMessage.type = Kirigami.MessageType.Information
        //showMessage(text)
    }

    function showMessage(text) {
        //errorMessage.text = text
        //errorMessage.visible = true
        //errorMessageTimer.running = true
    }

    function removeMessage() {
        //errorMessage.visible = false
        //errorMessageTimer.running = false
    }

//    QuestionThemes {
//        id: themes
//        onModelChanged: {
//            const model = themes.getThemeModel();
//            appendReceivedThemes(model)
//        }
//    }

    ColumnLayout {
        id: themeLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 8

//        Kirigami.ActionToolBar {
//            id: themeBar
//            Layout.fillWidth: true

//            flat: false
//            actions: Kirigami.Action {
//                id: themeAction
//                text: newThemeAction.text

//                Kirigami.Action {
//                    id: newThemeAction
//                    text: qsTr("New theme")
//                    shortcut: "Ctrl+T"
//                    onTriggered: {
//                        themeAction.text = text
//                        themeNameField.focus = true
//                    }
//                }
//            }
//        }

        RowLayout{

            Label {
                id: themeLabel
                text: qsTr("Theme:")
            }

            ComboBox {
                id : themeName
                //textRole: "text"
                //valueRole: "value"
                Layout.fillWidth: true
                //Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                editable: true
                currentIndex: -1
                //editText: currentIndex === -1 ? "New theme" : currentText
                model: admin.themes.themesModel.data

            }
        }

        RowLayout {
            id: difficultyRow
            property int activeIdx: 0
            Label {
                id:difficultyLabel
                text: qsTr("Difficulty:")
            }
            Repeater {
                //Layout.fillWidth: true
                //Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                model: [qsTr("Easy"),  qsTr("Medium"), qsTr("Hard")]
                RadioButton {
                    text:modelData
                    checked: index==difficultyRow.activeIdx
                    onClicked: difficultyRow.activeIdx=index
                }
            }
        }

//        Controls.TextField {
//            id: themeNameField
//            Layout.fillWidth: true
//            placeholderText: qsTr("Theme name")
//            //visible: themeAction.text === newThemeAction.text
//        }
    }


    ColumnLayout {
        id: editorStub
        anchors.top: themeLayout.bottom
        anchors.bottom: bottomRow.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 12
    }

//    Timer {
//        id: errorMessageTimer
//        interval: 10000; repeat: false
//        onTriggered: errorMessage.visible = false
//    }

//    Kirigami.InlineMessage {
//        id: errorMessage
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.bottom: bottomRow.top
//        type: Kirigami.MessageType.Error
//    }

    RowLayout {
        id: bottomRow
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.alignment: Qt.AlignJustify

        RowLayout {
            id: settingsRow
//            Kirigami.ActionToolBar {
//                id: toolBar
//                flat: false
//                actions: [
//                    Kirigami.Action {

//                        id: difficultyAction
//                        text: easyDifficultyAction.text

//                        // TODO maybe get difficulty types from Cpp?
//                        Kirigami.Action {
//                            id: easyDifficultyAction
//                            text: qsTr("Easy")
//                            shortcut: "Ctrl+Shift+E"
//                            onTriggered: difficultyAction.text = text
//                        }
//                        Kirigami.Action {
//                            id: mediumDifficultyAction
//                            shortcut: "Ctrl+Shift+M"
//                            text: qsTr("Medium")
//                            onTriggered: difficultyAction.text = text
//                        }
//                        Kirigami.Action {
//                            id: hardDifficultyAction
//                            shortcut: "Ctrl+Shift+H"
//                            text: qsTr("Hard")
//                            onTriggered: difficultyAction.text = text
//                        }
//                    },
//                    Kirigami.Action {

//                        Component {
//                            id: switchComponent
//                            Controls.Switch {
////                                id: activeSwitch
//                                checked: true
//                                text: checked ? qsTr("Active") : qsTr("Inactive")
//                            }
//                        }

//                        shortcut: "Ctrl+Shift+A"
//                        displayComponent: switchComponent
//                        onTriggered: getActiveSwitch().toggle()
//                    }
//                ]

//            }
        }

        Button {
            Layout.alignment: Qt.AlignRight
            visible: getQuestionWidget().questionId < 0
            text: qsTr("Reset")
            icon.name: "edit-reset"
            onClicked: {
                updateQuestionEditor()
            }
        }

        Button {
            Layout.alignment: Qt.AlignRight
            visible: getQuestionWidget().questionId >= 0
            text: qsTr("Delete")
            icon.name: "delete"
            onClicked: {
                admin.database.deleteQuestion(getQuestionWidget().questionId)
                updateQuestionEditor()
                search()
            }
        }

        Button {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Save")
            icon.name: "document-save"
            onClicked: save()
        }

        Action {
            shortcut: StandardKey.Save
            onTriggered: save()
        }
    }

//    Connections {
//        target: QuestionSaver
//        function onQuestionSaved() {
//            showSuccess(qsTr("Saved!"))
//        }
//        function onSaveFailed(message) {
//            showError(message)
//        }
//    }

//    Component {
//        id: dynamicAction
//        Kirigami.Action {
//            required property string title
//            text: title
//            onTriggered: themeAction.text = text
//        }
//    }

//    // TODO rework; referencing 'activeSwitch' not works
//    function getActiveSwitch() {
//        return toolBar.children[0].children[2]
//    }

    function getQuestionWidget() {
        return editorStub.children[0]
    }

    function load(questionModel) {
        //console.log(JSON.stringify(questionModel))
        themeName.editText = questionModel.theme
        difficultyRow.activeIdx = questionModel.difficulty
        getQuestionWidget().loadQuestion(questionModel)
    }

    function save() {

        const theme = themeName.editText
        if (!theme || theme.length === 0) {
            console.log("No theme")
            return
        }

        const difficulty = difficultyRow.activeIdx

        showInfo(qsTr("Saving.."))
        try {
            getQuestionWidget().saveQuestion(theme, difficulty, false)
            search()
        } catch(e) {
            showError(qsTr("Unhandled error while saving: %1").arg(e))
        }
    }

    function appendReceivedThemes(themeModel) {
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
