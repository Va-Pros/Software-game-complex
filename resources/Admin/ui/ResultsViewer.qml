import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Flickable {
   id: resultsViewer

    property string name: "resultsViewer"
    property string title: qsTr("Results viewer")

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item{
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.25 + pane.padding * 2
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
                        Pane{
                            id: pane
                            Label {
                                id: titleRightPanel
                                font.italic: true
                                text: qsTr("Search Parameters:")
                                font.pixelSize: 10 * 1.5
                            }
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
                            ComboBox {
                                textRole: "text"
                                valueRole: "value"
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: titleModel
                                    ListElement { text: qsTr("")}
                                    ListElement { text: qsTr("Any")}
                                    // titleModel.append({text: theme[idx]})
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
                            ComboBox {
                                textRole: "text"
                                valueRole: "value"
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: platoonModel
                                    ListElement { text: qsTr("")}
                                    ListElement { text: qsTr("Any")}
                                    // platoonModel.append({text: theme[idx]})
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
                        Pane{
                            Label {
                                id: tittleResultsPanel
                                font.italic: true
                                text: qsTr("Results:")
                                font.pixelSize: 10 * 1.5
                            }
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
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.6
            id: resultVieverSwap
            focus: true
            orientation: Qt.Vertical
            anchors.top: parent.bottom
            currentIndex: 0
            onCurrentIndexChanged: {
                resultsPanel.index = currentIndex
            }
            Repeater {
                model: []
                Loader {
                    id: pageExample
                    property string title: active? item.title:"..."
                    active: true
                    source: "ResultArea.qml"
                    //onLoaded: item.init()
                }
            }
        }
    }

}
