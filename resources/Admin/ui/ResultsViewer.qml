import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13
import QtQuick.Controls 1.4 as OldControls

Flickable {
   id: resultsViewer

    property string name: "resultsViewer"
    property string title: qsTr("Results viewer")

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item{
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.25
            SplitView {
                anchors.fill: parent
                orientation: Qt.Vertical
                Item {
                   SplitView.minimumHeight: resultsSearchPanel.height
                    ColumnLayout {
                        id: resultsSearchPanel
                        anchors.left : parent.left
                        anchors.right : parent.right
                        spacing: 0
                        Label {
                            id: titleRightPanel
                            font.italic: true
                            text: qsTr("Search Parameters:")
                            font.pixelSize: buttonSearch.height * 0.5
                        }
                        //todo: date
                        //RowLayout{}
                        RowLayout{
                            Pane{
                                id: labelPanel
                                contentWidth: Math.max(tittleLabel.width, platoonLabel.width, nameLabel.width)
                                Label {
                                    id:tittleLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Tittle:")
                                }
                            }
                            OldControls.ComboBox {
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: ttittleModel
                                    ListElement { text: ""}
                                    ListElement { text: "Any"}
                                    // themeModel.append({text: theme[idx]})
                                }
                            }
                        }
                        RowLayout{
                            Pane{
                                contentWidth: labelPanel.contentWidth
                                Label {
                                    id:platoonLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Platoon:")
                                }
                            }
                            OldControls.ComboBox {
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: platoonModel
                                    ListElement { text: ""}
                                    ListElement { text: "Any"}
                                    // themeModel.append({text: theme[idx]})
                                }
                            }
                        }
                        RowLayout{
                            Pane{
                                contentWidth: labelPanel.contentWidth
                                Label {
                                    id: nameLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Name:")
                                }
                            }
                            TextField {
                                id: nameField
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
        //                 Button {
        //                     id: buttonSingleChoice
        //                     Layout.fillWidth: true
        //                     text: qsTr("Single choice")
        //                     onClicked: questionCreatorSwap.currentIndex = 1
        //                     flat: questionCreatorPanel.index != 0
        //                 }
                    }

                }
            }
        }
        SwipeView {
            id: resultVieverSwap
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

            Loader {
                // index 0
                id: pageExample
                property string title: active? item.title:"..."
                active: true
                source: "ResultArea.qml"
                //onLoaded: item.init()
            }
        }
    }
}
