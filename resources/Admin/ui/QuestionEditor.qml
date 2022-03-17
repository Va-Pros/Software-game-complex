import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Flickable {
   id: questionEditor

    property string name: "questionEditor"
    property string title: qsTr("Question editor")

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item{
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.25
            SplitView {
                anchors.fill: parent
                orientation: Qt.Vertical
                Item {
                   SplitView.minimumHeight: questionEditorPanel.height
                    ColumnLayout {
                        id: questionEditorPanel
                        anchors.left : parent.left
                        anchors.right : parent.right
                        spacing: 0
                        Label {
                            id: titleRightPanel
                            font.italic: true
                            text: qsTr("Search Parameters:")
                            font.pixelSize: buttonSearch.height * 0.5
                        }
                        RowLayout{
                            Pane{
                                id: labelPanel
                                contentWidth: Math.max(contentLabel.width, complexityLabel.width, themeLabel.width)
                                Label {
                                    id: complexityLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Complexity:")
                                }
                            }
                            ComboBox {
                                Layout.fillWidth: true
                                id: complexityMosel
                                editable: false
                                model: [qsTr("Any"), qsTr("Easy"), qsTr("Medium"), qsTr("Hard"), qsTr("Easy or Medium"), qsTr("Medium or Hard"), qsTr("Easy or Hard")]
                            }
                        }
                        RowLayout{
                            Pane{
                                contentWidth: labelPanel.contentWidth
                                Label {
                                    id:themeLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Theme:")
                                }
                            }
                            ComboBox {
                                textRole: "text"
                                valueRole: "value"
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: themeModel
                                    ListElement { text: qsTr("")}
                                    ListElement { text: qsTr("Any")}
                                    // themeModel.append({text: theme[idx]})
                                }
                            }
                        }
                        RowLayout{
                            Pane{
                                contentWidth: labelPanel.contentWidth
                                Label {
                                    id: contentLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Content:")
                                }
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
                        }
                    }

                }
                Item {
                    SplitView.minimumWidth: titleRightPanel.width
                    ColumnLayout {
                        id: resultsPanel
                        anchors.left : parent.left
                        anchors.right : parent.right
                        spacing: 0
                        property var index: 0
                        //onCurrentIndexChanged: {
                            //console.log(currentIndex);
                        //}

                        Label {
                            id: tittleResultsPanel
                            font.italic: true
                            text: qsTr("Results:")
                            font.pixelSize: buttonSearch.height * 0.5
                        }
                        Repeater {
                            model: []
                            Button {
                                id: buttonSingleChoice
                                Layout.fillWidth: true
                                text: modelData
                                //onClicked: questionCreatorSwap.currentIndex = 1
                                //flat: questionCreatorPanel.index != 0
                            }
                        }
                    }

                }
            }
        }

        SwipeView {
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.8
            id: questionEditorSwap
            focus: true
            orientation: Qt.Vertical
            anchors.top: parent.bottom
//             anchors.left: parent.left
            //anchors.right: parent.right
            //anchors.bottom: parent.bottom
            currentIndex: 0
            onCurrentIndexChanged: {
                resultsPanel.index = currentIndex
            }
            Repeater {
                model: []
                Loader {
                    // index 0
                    id: pageExample
                    property string title: active? item.title:"..."
                    active: true
                    source: "QuestionArea.qml"
                    //onLoaded: item.init()
                }
            }
        }
    }

}
