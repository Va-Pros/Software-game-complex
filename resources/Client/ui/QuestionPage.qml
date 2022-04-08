import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: questionPage
    anchors.margins: 16

    Connections {
        target: client

        // TODO: rewrite
        function onNewMessage(message) {
            console.log("newMessage:", message)
            var data = message.split(';')
            if (data[0] !== "0") return
            data = data.splice(1);
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
//            qu3.push([]);
            qu3.splice(0, 1)

            console.log("parsed:", JSON.stringify(qu3))

            questionCount = k;

            resultPage.model = qu3;
            questionStack.length=k;

            resultsModel.model = k

            //console.log(qu3);
        }
    }

    property int questionIndex: 0
    property int questionCount: 0
    property real testTime: 10 // min
    property int timeLeft: testTime * 60 * 1000

    Keys.onPressed: {
        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            if (event.modifiers & Qt.ShiftModifier) {
                if (questionIndex > 0) {
                    questionIndex--
                }
            } else {
                if (questionIndex < questionCount - 1) {
                    questionIndex++
                }
            }
        }
    }

    Item {

        anchors.fill: parent
//        orientation: Qt.Horizontal
        anchors.margins: 16


        Item {
            SplitView.fillWidth: true
            clip: true
            anchors.left: parent.left
            anchors.right: rightPanel.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 8

            StackLayout {
                //anchors.centerIn: parent
                anchors.left: parent.left
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                id: questionStack
                property int length: 0
                property var pages: ["SingleChoiceArea", "MultipleChoiceArea", "TypeInArea", "MatchArea", "DropdownFillArea", "TypeInFillArea"]
                focus: true
                currentIndex: questionIndex
                Repeater {
                    id: resultPage
                    model: []
                    Loader {
                        // index 0
                        id: pageExample
                        property string title: active? item.title:"..."
                        active: true
                        source: ("QuestionArea/" + questionStack.pages[modelData[4]] + ".qml")
                        onLoaded: {
                            //console.log("loadedFor:", modelData)
                            item.init(modelData)
                        }
                    }
                }
            }

            RowLayout{
                //anchors.bottom: parent.bottom
                anchors.top: questionStack.bottom
                anchors.right: parent.right
                 Button {
                    id: prevQuestion1
                    Layout.fillWidth: true
                    text: qsTr("Prev")
                    visible: questionIndex > 0
                    onClicked: questionIndex--
                }
                Button {
                    id: nextQuestion1
                    Layout.fillWidth: true
                    text: qsTr("Next")
                    visible: questionIndex < resultsModel.model - 1
                    onClicked: questionIndex++
                }
            }
        }

        Item {

            id: rightPanel

            SplitView.minimumWidth: Math.max(tittleResultsPanel.width) * 1.25 //+ pane.padding * 2
            implicitWidth: Math.max(tittleResultsPanel.width) * 1.25 //+ pane.padding * 2
            implicitHeight: parent.height
            anchors.right: parent.right


            Rectangle {
                id: rightPanelDelimiter
                implicitWidth: 2
                implicitHeight: parent.height
                color: "grey"
                anchors.rightMargin: 10
                anchors.leftMargin: 10
            }

            ColumnLayout {
                id: resultsPanel
                anchors.left : rightPanelDelimiter.right
                anchors.right : parent.right
                spacing: 10
                anchors.leftMargin: 8

                Label {
                    id: tittleResultsPanel
                    font.italic: true
                    text: qsTr("Questions:")
                    font.pixelSize: 24
                }


                GridLayout {
                    columns: 5

                    Repeater {
                        id: resultsModel
                        model: 0
                        Button {
                            id: buttonSingleChoice
                            Layout.fillWidth: true
                            text: index + 1
                            onClicked: questionIndex = index
                            flat: index !== questionIndex
                        }
                    }
                }

                Timer {
                    id: testFinishTimer
                    interval: testTime * 60 * 1000 // millisec
                    repeat: false
                    running: true
                    onTriggered: endTest()
                }


                Timer {
                    id: testShowTimer
                    interval: 500 // millisec
                    repeat: true
                    running: true
                    onTriggered: {
                        timeLeft -= interval
                    }
                }

                Label {
                    id: timeLeftLabel
                    property int mins: Math.floor(timeLeft / (60 * 1000))
                    property int secs: Math.floor((timeLeft - mins * 60 * 1000) / 1000)
                    text: qsTr("Time left: %1:%2").arg(mins).arg(secs < 10 ? '0' + secs : secs)
                    font.pixelSize: 20
                }

                Button {
                    id: finishButton
                    Layout.fillWidth: true
                    text: qsTr("Finish test")
                    onClicked: endTest()
                }
            }

        }
    }

    function endTest() {
        console.log("hi, Arti!");
        //client.sendMessage("666;")
        load_page("GamePage");
    }

    function saveAnswer(answer) {
        client.sendMessage(`1;${currentIndex};${answer}`)
    }
}

