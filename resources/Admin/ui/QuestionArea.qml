import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Pane {
    id: questionArea
    property string title: qsTr("Question area")
    property int type: 2
    property var answers_list: [[qsTr("")]]
    property var is_correct: [[true]]
    property var singleChoiceIdx: [0]
    Connections {
        target: database
    }
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right
        RowLayout{
            Pane{
                id: themePanel
                contentWidth: Math.max(themeLabel.width, difficultyLabel.width, contentLabel.width)
                Label {
                    id:themeLabel
                    text: qsTr("Theme:")
                }
            }
            ComboBox {
                id : themeName
                textRole: "text"
                valueRole: "value"
                Layout.fillWidth: true
                Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                editable: true
                model: ListModel {
                    id: themeModel
                    ListElement { text:  qsTr("")}
                    // themeModel.append({text: theme[idx]})
                }
            }
        }
        RowLayout {
            id: difficultyRow
            property int activeIdx: 0
            Pane{
                contentWidth: themePanel.contentWidth
                Label {
                    id:difficultyLabel
                    text: qsTr("Difficulty:")
                }
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
        Pane {
            Layout.fillWidth: true
            ColumnLayout {
                anchors.fill: parent
                Label {
                    id:contentLabel
                    text: qsTr("Content:")
                }

                TextArea {
                    id:descriptionArea
                    Layout.fillWidth: true
                    Layout.minimumHeight: themeName.height * 2
                    placeholderText: qsTr("Enter description")
                }
            }
        }
        RowLayout{
            Repeater {
                id:listModel
                model:answers_list.length
                //required property int index
                Pane{
                    Layout.fillWidth: true
                    ColumnLayout{
                        id:answerList
                        property int topIndex:index
                        anchors.fill: parent
                        Label {
                            text: qsTr(`Answer options${answers_list.length>1?` {${answerList.topIndex}}`:""}:`)
                        }
                        ButtonGroup {
                            id: singleChoiceGroup
                        }
                        Repeater {
                            id: answersModel
                            model: answers_list[answerList.topIndex].length
                            RowLayout {
                                RadioButton{
                                    ButtonGroup.group: singleChoiceGroup
                                    checked:(questionArea.type%4)==0&&is_correct[answerList.topIndex][index]
                                    onCheckedChanged: {
                                        is_correct[answerList.topIndex][singleChoiceIdx[answerList.topIndex]]=false;
                                        is_correct[answerList.topIndex][index]=true;
                                        singleChoiceIdx[answerList.topIndex] = index;
                                    }
                                    visible: (questionArea.type%4)==0
                                }
                                CheckBox{
                                    checked:is_correct[answerList.topIndex][index]
                                    onCheckedChanged: is_correct[answerList.topIndex][index]=checked
                                    visible: questionArea.type==1
                                }
                                TextField{
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                    text:answers_list[answerList.topIndex][index]
                                    onEditingFinished:{
                                        answers_list[answerList.topIndex][index] = text;
                                    }
                                }
                                Button {
                                    icon.name: "delete"
                                    visible: answersModel.model > 1 // todo: check is is_correct not empty and contain true element
                                    onClicked: {
                                        answers_list[answerList.topIndex].splice(index, 1);
                                        is_correct[answerList.topIndex].splice(index, 1);
                                        answersModel.model--;
                                    }
                                }
                            }
                        }
                        RowLayout{
                            Button {
                                Layout.fillWidth: true
                                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                Layout.alignment: Qt.AlignLeft
                                text: qsTr("Add option")
                                icon.name: "list-add"
                                onClicked: {
                                    answers_list[answerList.topIndex].push(qsTr(""));
                                    is_correct[answerList.topIndex].push((questionArea.type%4)!=0);
                                    answersModel.model++;
                                }
                            }
                            Button {
                                Layout.fillWidth: true
                                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                Layout.alignment: Qt.AlignLeft
                                text: qsTr("Delete list")
                                icon.name: "delete"
                                visible:answers_list.length > 1
                                onClicked: {
                                    answers_list.splice(answerList.topIndex, 1);
                                    is_correct.splice(answerList.topIndex, 1);
                                    listModel.model--;
                                }
                            }
                        }
                    }
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Add list")
                icon.name: "list-add"
                visible:questionArea.type>3
                onClicked: {
                    answers_list.push([qsTr("")]);
                    is_correct.push([true]);
                    singleChoiceIdx.push([0]);
                    listModel.model++;
                }
            }
        }
        RowLayout {
            Button {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                text: !true?qsTr("Delete"):qsTr("Clear")
                icon.name: "delete"
                onClicked: {}
            }

            Button {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                text: qsTr("Save")
                icon.name: "document-save"
                onClicked: {
                    console.log(answers_list)
                    console.log(is_correct)
                    console.log()
                    //database.insertIntoQuestionTable(themeName.editText, difficultyRow.activeIdx, descriptionArea.text, questionArea.type, answers_list, is_correct);
                }
            }
        }
    }
    function init(type) {
        questionArea.type=type;
    }
}
