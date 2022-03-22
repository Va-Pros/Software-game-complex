import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13
import org.kde.kirigami 2.4 as Kirigami

Flickable {
    id: gameManager

    property string name: "GameManager"
    property string title: qsTr("Game manager")

    Connections {
        target: server
    }
    Pane{
        anchors.fill: parent
        ColumnLayout {
            Layout.alignment: Qt.AlignCenter
            RowLayout{
                Label{
                    text: qsTr("Title:")
                    font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.25
                }
                TextField {
                    id: nameField
                    Layout.fillWidth: true
//                     Layout.maximumWidth: parent.width- pane.padding*2
                }
            }
            RowLayout{
                Layout.alignment: Qt.AlignCenter
                Label {
                    id:themeLabel
                    text: qsTr("Theme:")
                }
                ComboBox {
                    id : themeName
                    textRole: "text"
                    valueRole: "value"
                    Layout.fillWidth: true
//                     Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                    editable: true
                    model: ListModel {
                        id: themeModel
                        ListElement { text:  qsTr("")}
                        // themeModel.append({text: theme[idx]})
                    }
                }
                Button {
                    Layout.fillWidth: true
    //                 Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                    text: qsTr("Add theme")
                    icon.name: "list-add"
                }
            }
            RowLayout{
            }
            Label{
                text: qsTr("Amount of questions:")
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.25
            }
            Pane{
                //Layout.maximumWidth: parent.width- pane.padding*2
                ColumnLayout{
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("Easy:")}
                        ComboBox {
                            id: easy
                            Layout.fillWidth: true
                            model: 11
                            editable: true
                            validator: IntValidator {
                                top: 10
                                bottom: 0
                            }
                        }
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("\tMedium:")}
                        ComboBox {
                            id: medium
                            Layout.fillWidth: true
                            model: 11
                            editable: true
                            validator: IntValidator {
                                top: 10
                                bottom: 0
                            }
                        }
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("\tHard:")}
                        ComboBox {
                            id: hard
                            Layout.fillWidth: true
                            model: 11
                            editable: true
                            validator: IntValidator {
                                top: 10
                                bottom: 0
                            }
                        }
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("\tTotal:")}
                        Label{
                            id:count
                            text:qsTr(`${easy.currentIndex+medium.currentIndex+hard.currentIndex}`)
                        }
                    }
                }
            }
            Label{
                text: qsTr("Grading rules:")
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.25
            }
            Pane{
                Layout.fillWidth: true
                ColumnLayout{
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("Satisfactory:")}
                        TextField {
                            Layout.fillWidth: true
                            id: satisfactory
                            validator: IntValidator {
                                top: 100
                                bottom: 0
                            }
                        }
                        Label{ text: qsTr("% or more")}
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("Good:")}
                        TextField {
                            id: good
                            Layout.fillWidth: true
                            validator: IntValidator {
                                top: 100
                                bottom: 0
                            }
                        }
                        Label{ text: qsTr("% or more")}
                    }
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{text:qsTr("Excellent:")}
                        TextField {
                            id: excellent
                            Layout.fillWidth: true
                            validator: IntValidator {
                                top: 100
                                bottom: 0
                            }
                        }
                        Label{ text: qsTr("% or more")}
                    }
                }
            }
            //Label{
                //text: qsTr("Game settings")
                //Layout.alignment: Qt.AlignCenter
                //font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
            //}
            Label {
                id:difficultyLabel
                text: qsTr("Situation difficulty:")
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.25
            }
            RowLayout {
                id: difficultyRow
                property int activeIdx: 0
                Layout.alignment: Qt.AlignCenter
                Repeater {
                    model: [qsTr("Easy"),  qsTr("Medium"), qsTr("Hard")]
                    RadioButton {
                        text:modelData
                        checked: index==difficultyRow.activeIdx
                        onClicked: difficultyRow.activeIdx=index
                    }
                }
            }
            Label {
                text: qsTr("Time:")
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.25
            }
            Pane{
                ColumnLayout{
                    RowLayout{
                        Layout.alignment: Qt.AlignCenter
                        Label{ text: qsTr("Test time:")}
                        TextField {
                            Layout.fillWidth: true
                            validator:IntValidator {
                                bottom: 0
                            }
                        }
                    }
                    RowLayout{
                        Label{ text: qsTr("\tGame time:")}
                        TextField {
                            Layout.fillWidth: true
                            validator:IntValidator {
                                bottom: 0
                            }
                        }
                    }
                }
            }
            Button {
                id: serverAvaliable
                Layout.fillWidth: true
                text: qsTr("Start Server")
                onClicked: {
                    if (!server.isServerAvailable()) {
                        server.onStart()
                        serverAvaliable.text = qsTr("Server Stop")
                    } else {
                        server.onStop()
                        serverAvaliable.text = qsTr("Start Server")
                    }
                }
            }
        }
    }
}
