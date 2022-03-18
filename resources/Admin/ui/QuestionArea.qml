import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Item {
    property string title: qsTr("Question area")
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right
        RowLayout{
            Pane{
                id: themePanel
                contentWidth: Math.max(themeLabel.width, complexityLabel.width, contentLabel.width)
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
            id: complexityRow
            Pane{
                contentWidth: themePanel.contentWidth
                Label {
                    id:complexityLabel
                    text: qsTr("Complexity:")
                }
            }
            Repeater {
                //Layout.fillWidth: true
                //Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                model: ListModel {
                    ListElement {
                        title: qsTr("Easy")
                        active: true
                    }
                    ListElement { title: qsTr("Medium")}
                    ListElement { title: qsTr("Hard")}
                }
                RadioButton {
                    required property string title
                    required property bool active
                    text:title
                    checked:active
                }
            }
        }
        Label {
            id:contentLabel
            text: qsTr("Content:")
        }
        TextArea {
            Layout.fillWidth: true
            Layout.minimumHeight: themeName.height * 2
            placeholderText: qsTr("Enter description")
        }
        Repeater {
            //anchors.fill: parent
            property string title: qsTr("Type in")
            model:1
            ColumnLayout{
                Label {
                    text: qsTr("Answer options:")
                }
                ButtonGroup {
                    id: singleChoiceGroup
                }
                Repeater {
                    model: ListModel {
                        id: answersList
                        ListElement { value: qsTr(""); correctAnswer: true}
                    }
                    RowLayout {
                        id: answersId
                        required property string value
                        //required property int index
                        required property bool correctAnswer
                        RadioButton {
                            ButtonGroup.group: singleChoiceGroup
                            checked:correctAnswer
                            onClicked:answersList.set(index, {correctAnswer: true})

                        }
                        TextField{
                            Layout.fillWidth: true
                            Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                            text:value
                            onEditingFinished:{
                                answersList.set(index, {value: answersId.text})
                            }
                        }
                        Button {
                            icon.name: "delete"
                            visible: answersList.count > 1 && !correctAnswer
                            onClicked: {
                                answersList.remove(index)
                            }
                        }
                    }
                }
                Button {
                    Layout.fillWidth: true
                    Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                    Layout.alignment: Qt.AlignLeft
                    text: qsTr("Add option")
                    icon.name: "list-add"
                    onClicked: {
                        answersList.append({ value: qsTr("")})
                    }
                }
            }
        }
        RowLayout {
            //Layout.alignment:Qt.AlignBottom
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
                onClicked: {}
            }
        }
    }
}
