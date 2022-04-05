import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "HelperWidgets"

Flickable {
    id: flickable

    property string name: "QuestionConstructor"
    property string title: qsTr("Question constructor")
    property int selectedType: 0
    property var searchModel: []
    property int selectedInSearch: -1



    onSelectedTypeChanged: {
        if (selectedType < 0) return
        //selectedInSearch = -1
        updateQuestionEditor()
    }

    onSelectedInSearchChanged: {
        if (selectedInSearch < 0) return
        //selectedType = -1
        const questionModel = searchModel[selectedInSearch]
        selectedType = questionModel.model
        //setQuestionEditorIndex(questionModel.model)
        pageQuestionCreator.item.load(questionModel)
    }

//    TabBar {
//        id: questionBar
//        anchors.left: parent.left
//        anchors.right: parent.right
//        currentIndex: 0
//        onCurrentIndexChanged: {
//            questionSwap.currentIndex = currentIndex
//        }
//        Repeater {
//            model: [qsTr("Question creator"), qsTr("Question editor")]
//            TabButton {
//                text: modelData
//                width: undefined
//            }
//        }
//    }

    ListModel {
        id: listTypeModel
        ListElement {
            questionType: qsTr("Single choice")
            widgetPath: "qrc:/ui/QuestionWidgets/SingleChoiceQuestionEditor.qml"
        }
        ListElement {
            questionType: qsTr("Multiple choice")
            widgetPath: "qrc:/ui/QuestionWidgets/MultipleChoiceQuestionEditor.qml"
        }
        ListElement {
            questionType: qsTr("Input")
            widgetPath: "qrc:/ui/QuestionWidgets/TypeInQuestionEditor.qml"
        }
        ListElement {
            questionType: qsTr("Match")
            widgetPath: "qrc:/ui/QuestionWidgets/MatchQuestionEditor.qml"
        }
        ListElement {
            questionType: qsTr("Dropdown fill")
            widgetPath: "qrc:/ui/QuestionWidgets/DropDownFillQuestionEditor.qml"
        }
        ListElement {
            questionType: qsTr("Type in fill")
            widgetPath: "qrc:/ui/QuestionWidgets/TypeInFillQuestionEditor.qml"
        }
    }


    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item {
            SplitView.fillHeight: true
            SplitView.minimumWidth: 300
            SplitView.maximumWidth: 500

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16


                TabBar {
                    id: questionTabBar
                    Layout.fillWidth: true
                    Repeater {
                        model: [qsTr("New"), qsTr("Edit")]
                        TabButton {
                            text: modelData
                            width: undefined
                        }
                    }
                }

                StackLayout {
                    currentIndex: questionTabBar.currentIndex

                    MyVerticalListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: listTypeModel
                        delegate: Button {
                            Layout.fillWidth: true
                            text: questionType
                            flat: selectedType !== index
                            onClicked: {
                                if (selectedType === index) selectedType = -1
                                selectedType = index
                                selectedInSearch = -1
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        Label {
                            id: titleRightPanel
                            font.italic: true
                            text: qsTr("Search:")
                            font.pixelSize: 20 * 1.5
                        }
                        RowLayout{
                            Label {
                                id: difficultyLabel
                                text: qsTr("Difficulty:")
                            }
                            ComboBox {
                                Layout.fillWidth: true
                                id: difficultyMosel
                                editable: false
                                model: [qsTr("Any"), qsTr("Easy"), qsTr("Medium"), qsTr("Hard")]
                            }
                        }
                        RowLayout{
                            Label {
                                id:themeLabel
                                text: qsTr("Theme:")
                            }
                            ComboBox {
                                id: themeName
                                Layout.fillWidth: true
                                editable: true
                                currentIndex: -1
                                model: admin.themes.themesModel.data
                            }
                        }
                        RowLayout{
                            Label {
                                id: contentLabel
                                text: qsTr("Content:")
                            }
                            TextField {
                                id: contentField
                                Layout.fillWidth: true
                            }
                        }
                        Button {
                            id: buttonSearch
                            Layout.fillWidth: true
                            text: qsTr("Search")
                            onClicked: {
                                searchModel = admin.database.selectAllFromQuestionTable(themeName.editText, contentField.text, difficultyMosel.currentIndex);
                            }
                        }

                        Label {
                            id: tittleResultsPanel
                            font.italic: true
                            text: qsTr("Results:")
                            font.pixelSize: 20 * 1.5
                        }

                        MyVerticalListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: searchModel
                            delegate: Button {
                                Layout.fillWidth: true
                                text: `${modelData.theme}:${modelData.description}`
                                onClicked: selectedInSearch = index
                                flat: selectedInSearch !== index
                            }
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            SplitView.fillWidth: true
            anchors.margins: 16

            Loader {
                Layout.fillHeight: true
                SplitView.fillWidth: true
                anchors.fill: parent
                anchors.margins: 16
                id: pageQuestionCreator

                Component.onCompleted: {
                    updateQuestionEditor()
                }
            }
        }
    }

    function updateQuestionEditor() {
        setQuestionEditorIndex(selectedType)
    }

    function setQuestionEditor(questionType, widgetPath) {
        pageQuestionCreator.setSource("QuestionCreator.qml", {questionType, widgetPath})
    }

    function setQuestionEditorIndex(index) {
        const item = listTypeModel.get(index)
        setQuestionEditor(item.questionType, item.widgetPath)
    }

}
