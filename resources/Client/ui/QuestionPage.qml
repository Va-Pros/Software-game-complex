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
                    onLoaded: item.init(modelData)
                }
            }
        }
    }
}
