import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.3

Flickable {
    id: resultsViewer

    property string name: "resultsViewer"
    property string title: qsTr("Results viewer")

    property var columnNames: {
        "name":         qsTr("Name"),
        "platoon":      qsTr("Platoon"),
        "role":         qsTr("Role"),
        "testScore":    qsTr("Test score"),
        "gameScore":    qsTr("Game score"),
        "totalScore":   qsTr("Total score"),
    }
    property string resultsName: "Test 01.04.2022"
    property var resultsDate: new Date(2022, 04 - 1, 01)

    TableModel {
        id: tableModel

        TableModelColumn { display: "name" }
        TableModelColumn { display: "platoon" }
        TableModelColumn { display: "role" }
        TableModelColumn { display: "testScore" }
        TableModelColumn { display: "gameScore" }
        TableModelColumn { display: "totalScore" }

        rows: [
            {
                "name": "Иванов Иван Иванович",
                "platoon": "1911",
                "role": qsTr("Attacker"), // NOTE: Store role as int/enum, but use here string representation
                "testScore": qsTr("In progress"),
                "gameScore": qsTr("Not started"),
                "totalScore": qsTr("In progress"),
            },
            {
                "name": "Петров Пётр Петрович",
                "platoon": "1910",
                "role": qsTr("Defender"), // NOTE: Store role as int/enum, but use here string representation
                "testScore": "5",
                "gameScore": "3",
                "totalScore": "4",
            },
        ]
    }

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

        Item {
            id: rightPanel
            SplitView.fillWidth: true
            anchors.margins: 16
            //visible: false

            Label {
                id: resultsNameLabel
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                text: resultsName
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 24
            }

            Label {
                id: resultsDateLabel
                anchors.top: resultsNameLabel.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                text: resultsDate.toLocaleDateString()
                font.pixelSize: 18
            }

            HorizontalHeaderView {
                id: horizontalHeader
                model: getColumnNames()
                syncView: tableView
                anchors.top: resultsDateLabel.bottom
                anchors.left: tableView.left
                anchors.right: tableView.right
                anchors.topMargin: 16
            }

            VerticalHeaderView {
                id: verticalHeader
                syncView: tableView
                anchors.left: parent.left
                anchors.top: tableView.top
                anchors.bottom: tableView.bottom
                anchors.leftMargin: 16
            }

            TableView {
                id: tableView
                model: tableModel
                anchors.top: horizontalHeader.bottom
                anchors.left: verticalHeader.right
                anchors.right: parent.right
                anchors.bottom: exportButton.top
                anchors.rightMargin: 16
                anchors.bottomMargin: 16


                onWidthChanged: tableView.forceLayout()
                columnWidthProvider: function(column) {
                    return tableView.width / Object.keys(tableModel.columns).length
                }
                delegate: Rectangle {
                    id: delegateRoot
                    //implicitWidth: cellLabel.width + 20 < 100 ? 100 : cellLabel.width + 20
                    implicitWidth: tableView.columnWidthProvider(index)
                    implicitHeight: 50
                    border.width: 1

                    MouseArea {
                        id: rootMouseArea
                        anchors.fill: delegateRoot
                        hoverEnabled: true
                    }
                    Label {
                        id: cellLabel
                        text: display
                        anchors.centerIn: parent
                        elide: Text.ElideRight
                        //width: tableView.columnWidthProvider(index)
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4

                        MouseArea {
                            id: labelMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                        }

                        ToolTip.visible: rootMouseArea.containsMouse || labelMouseArea.containsMouse // TODO Find a way to use only one mouse area
                        ToolTip.text: display
                    }
                }
            }




            FileDialog {
                id: fileDialog
                title: "Please choose a file"
                folder: shortcuts.home
                selectExisting: false
                nameFilters: ["Excel CSV (*.csv)"]
                onAccepted: {
                    console.log("You chose: " + fileDialog.fileUrls)

                    const header = getColumnNames().join(';')
                    const rows = tableModel.rows.map(item => resultItemArray(item).join(';')).join('\n')
                    const data = header + '\n' + rows
                    console.log(data)
                    saveFile(fileDialog.fileUrl, data)
                }
                onRejected: {
                    console.log("Canceled")

                }
            }

            Button {
                id: exportButton
                text: qsTr("Export data")
                width: 300
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.topMargin: 16
                anchors.bottomMargin: 16
                onClicked: {
                    fileDialog.open()
                }
            }

        }
    }

    function getColumnNames() {
        return Object.values(tableModel.columns).map(item => columnNames[item.display])
    }

    function resultItemArray(item) {
        return Object.keys(columnNames).map(column => item[column])
    }

    // TODO find better way
    function saveFile(fileUrl, text) {
        const request = new XMLHttpRequest();
        request.open("PUT", fileUrl, false);
        request.send(text);
        return request.status;
    }

}
