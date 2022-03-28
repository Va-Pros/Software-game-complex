import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Flickable {
    id: questionCreator

    property string name: "QuestionCreator"
    property string title: qsTr("Question creator")

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Item {
            SplitView.minimumWidth: titleRightPanel.width + pane.padding * 2
            ColumnLayout {
                id: questionCreatorPanel
                anchors.left : parent.left
                anchors.right : parent.right
                spacing: 0
                property var index: 2
                //onCurrentIndexChanged: {
                    //console.log(currentIndex);
                //}
                Pane{
                    id: pane
                    Label {
                        id: titleRightPanel
                        font.italic: true
                        text: qsTr("Choose the type of question:")
                        font.pixelSize: 20 * 1.5
                    }
                }
                Repeater {
                    model: [qsTr("Single choice"), qsTr("Multiple choice"), qsTr("Type in"), qsTr("Match"), qsTr("Dropdown fill"), qsTr("Type in fill")]
                    Button {
                        Layout.fillWidth: true
                        text: modelData
                        onClicked: questionCreatorSwap.currentIndex = index+1
                        flat: questionCreatorPanel.index != index+1
                    }
                }
            }

        }

        SwipeView {
            SplitView.minimumWidth: titleRightPanel.width * 1.6
            id: questionCreatorSwap
            focus: true
            orientation: Qt.Vertical
            anchors.top: parent.bottom
//             anchors.left: parent.left
//             anchors.fill: parent
            currentIndex: 2
            onCurrentIndexChanged: {
                if(currentIndex==0)currentIndex=6;
                if(currentIndex==7)currentIndex=1;
                questionCreatorPanel.index = currentIndex
            }
            Repeater {
                model: 8
                Loader {
                    id: pageSingleChoice
                    property string title: active? item.title:"..."
                    active: true
                    source: "QuestionArea.qml"
                    onLoaded: item.init(index)
                }
            }
        }
    }


}
