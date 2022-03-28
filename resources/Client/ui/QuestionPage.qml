import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.4 as Kirigami

Page {
    title: qsTr("Question Page")

    Label {
        text: qsTr("Question Page")
    }
    Connections {
        target: client
        function onNewMessage(message) {
            var data = message.split(';').splice(1);
            var data2=data.reduce((rows, key, index) => (index % 7 == 0 ? rows.push([key]) : rows[rows.length-1].push(key)) && rows, []);
            var qu3=[[]], k=0;
            for(var i=0;i<data2.length;i++){
                if(!i||qu3[k][0]!=data2[i][0]){
                    if(i&&qu3[k][6]!="0")
                        qu3[k][5]=qu3[k][5].reduce((rows, key, index) => (index % (qu3[k][6]-0) == 0 ? rows.push([key]) : rows[rows.length-1].push(key)) && rows, []);
                    qu3.push([]);
                    k++;
                    if(data2[i][0]<1)break;
                    for(var j=0;j<7;j++){
                        if(j==5)
                            qu3[k].push([]);
                        else
                            qu3[k].push(data2[i][j]);
                    }
                }
                //if(data2[i][6])
                    qu3[k][5].push(data2[i][5]);
            }
            qu3.push([]);
            resultsModel.model = k
            resultPage.model = qu3;
            questionEditorSwap.length=k;
            //console.log(qu3);
        }
    }
    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item{
            SplitView.minimumWidth: Math.max(tittleResultsPanel.width) * 1.25 + pane.padding * 2
            ColumnLayout {
                id: resultsPanel
                anchors.left : parent.left
                anchors.right : parent.right
                spacing: 0
                property var index: 0
                //onCurrentIndexChanged: {
                    //console.log(currentIndex);
                //}
                Button {
                        id: finishButton
                        Layout.fillWidth: true
                        text: `Finish test`
                        onClicked: {
                            console.log("hi, Arti!");
                            load_page("GamePage");
                        }
                    }
                Pane{
                    id: pane
                    Label {
                        id: tittleResultsPanel
                        font.italic: true
                        text: qsTr("Questions:")
                        font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
                    }
                }
                Repeater {
                    id: resultsModel
                    model: 0
                    Button {
                        id: buttonSingleChoice
                        Layout.fillWidth: true
                        text: `Question  ${index + 1}`
                        onClicked: questionEditorSwap.currentIndex = index + 2
                        flat: questionEditorSwap.currentIndex != index + 2
                    }
                }
            }

        }

        SwipeView {
            SplitView.minimumWidth: Math.max(tittleResultsPanel.width) * 1.8
            id: questionEditorSwap
            property int length: 0
            focus: true
            orientation: Qt.Vertical
            anchors.top: parent.bottom
            currentIndex: 0
            onCurrentIndexChanged: {
                if(length){
                    if(currentIndex==1)currentIndex=length+1;
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
                    source: (modelData[4] == 3) ?  "MatchArea.qml" : "FillInArea.qml"
                    onLoaded: item.init(modelData)
                }
            }
        }
    }
}

