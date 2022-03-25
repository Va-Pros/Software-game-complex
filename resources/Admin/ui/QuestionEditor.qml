import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Flickable {
   id: questionEditor

    property string name: "questionEditor"
    property string title: qsTr("Question editor")
    Connections {
        target: database
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
                   SplitView.minimumHeight: questionEditorPanel.height
                    ColumnLayout {
                        id: questionEditorPanel
                        anchors.left : parent.left
                        anchors.right : parent.right
                        spacing: 0
                        Pane{
                            id: pane
                            Label {
                                id: titleRightPanel
                                font.italic: true
                                text: qsTr("Search Parameters:")
                                font.pixelSize: 20 * 1.5
                            }
                        }
                        RowLayout{
                            Pane{
                                id: labelPanel
                                contentWidth: Math.max(contentLabel.width, difficultyLabel.width, themeLabel.width)
                                Label {
                                    id: difficultyLabel
//                                     wrapMode: Label.WordWrap
                                    text: qsTr("Difficulty:")
                                }
                            }
                            ComboBox {
                                Layout.fillWidth: true
                                id: difficultyMosel
                                editable: false
                                model: [qsTr("Any"), qsTr("Easy"), qsTr("Medium"), qsTr("Hard")]
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
                                id: themeName
                                textRole: "text"
                                valueRole: "value"
                                Layout.fillWidth: true
                                editable: true
                                model: ListModel {
                                    id: themeModel
                                    ListElement { text: qsTr("")}
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
                            onClicked: {
                                var ans = database.selectAllFromQuestionTable(themeName.editText, contentField.text, difficultyMosel.currentIndex);
                                var ans2=ans.reduce((rows, key, index) => (index % 8 == 0 ? rows.push([key]) : rows[rows.length-1].push(key)) && rows, []);
                                ans2.push([-1]);
                                var ans3=[[]], k=0;
                                for(var i=0;i<ans2.length;i++){
                                    if(!i||ans3[ans3.length-1][0]!=ans2[i][0]){
                                        if(i)
                                            for(var j=5;j<7;j++)
                                                ans3[k][j]=ans3[k][j].reduce((rows, key, index) => (index % ans3[k][7] == 0 ? rows.push([key]) : rows[rows.length-1].push(key)) && rows, []);
                                        ans3.push([]);
                                        k++;
                                        if(ans2[i][0]<1)break;
                                        for(var j=0;j<8;j++){
                                            if(j==5||j==6)
                                                ans3[k].push([]);
                                            else
                                                ans3[k].push(ans2[i][j]);
                                        }
                                    }
                                    if(ans2[i][5])
                                        for(var j=5;j<7;j++)
                                            ans3[k][j].push(ans2[i][j]);
                                }
                                //console.log(124, ans3);
                                var results = [];
                                for(var i=1;i<ans3.length-1;i++)
                                    results.push(`${ans3[i][1]}:${ans3[i][3]}`);
                                resultsModel.model = results;
                                resultPage.model = ans3;
                                questionEditorSwap.length = ans3.length-2;
                            }
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
                                font.pixelSize: 20 * 1.5
                            }
                        }
                        Repeater {
                            id: resultsModel
                            model: []
                            Button {
                                id: buttonSingleChoice
                                Layout.fillWidth: true
                                text: modelData
                                onClicked: questionEditorSwap.currentIndex = index + 2
                                flat: questionEditorSwap.currentIndex != index + 2
                            }
                        }
                    }

                }
            }
        }

        SwipeView {
            SplitView.minimumWidth: Math.max(titleRightPanel.width) * 1.8
            id: questionEditorSwap
            property int length: 0
            focus: true
            orientation: Qt.Vertical
            anchors.top: parent.bottom
//             anchors.left: parent.left
            //anchors.right: parent.right
            //anchors.bottom: parent.bottom
            currentIndex: 0
            onCurrentIndexChanged: {
                if(length){
                    if(currentIndex==0)currentIndex=length+1;
                    if(currentIndex==length+2)currentIndex=1;
                    resultsPanel.index = currentIndex
//                     console.log(currentIndex);
                }
            }
            Repeater {
                id: resultPage
                model: []
                Loader {
                    // index 0
                    id: pageExample
                    property string title: active? item.title:"..."
                    active: true
                    source: "QuestionArea.qml"
                    onLoaded: item.initFromArray(modelData)
                }
            }
        }
    }

}
