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
            SplitView.minimumWidth: titleRightPanel.width
            ColumnLayout {
                id: questionCreatorPanel
                anchors.left : parent.left
                anchors.right : parent.right
                spacing: 0
                property var index: 2
                //onCurrentIndexChanged: {
                    //console.log(currentIndex);
                //}

                Label {
                    id: titleRightPanel
                    font.italic: true
                    text: qsTr("Choose the type of question:")
                    font.pixelSize: buttonSingleChoice.height * 0.5
                }
                Button {
                    id: buttonSingleChoice
                    Layout.fillWidth: true
                    text: qsTr("Single choice")
                    onClicked: questionCreatorSwap.currentIndex = 0
                    flat: questionCreatorPanel.index != 0
                }
                Button {
                    id: buttonMultipleChoice
                    Layout.fillWidth: true
                    text: qsTr("Multiple choice")
                    onClicked: questionCreatorSwap.currentIndex = 1
                    flat: questionCreatorPanel.index != 1
                }
                Button {
                    id: buttonTypeIn
                    Layout.fillWidth: true
                    text: qsTr("Type in")
                    onClicked: questionCreatorSwap.currentIndex = 2
                    flat: questionCreatorPanel.index != 2
                }
                Button {
                    id: buttonMatch
                    Layout.fillWidth: true
                    text: qsTr("Match")
                    onClicked: questionCreatorSwap.currentIndex = 3
                    flat: questionCreatorPanel.index != 3
                }
                Button {
                    id: buttonDropdownFill
                    Layout.fillWidth: true
                    text: qsTr("Dropdown fill")
                    onClicked: questionCreatorSwap.currentIndex = 4
                    flat: questionCreatorPanel.index != 4
                }
                Button {
                    id: buttonTypeInFill
                    Layout.fillWidth: true
                    text: qsTr("Type in fill")
                    onClicked: questionCreatorSwap.currentIndex = 5
                    flat: questionCreatorPanel.index != 5
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
            //anchors.right: parent.right
            //anchors.bottom: parent.bottom
            currentIndex: 2
            onCurrentIndexChanged: {
                questionCreatorPanel.index = currentIndex
            }

            Loader {
                // index 0
                id: pageSingleChoice
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
            Loader {
                // index 1
                id: pageMultipleChoice
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
            Loader {
                // index 2
                id: pageTypeIn
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
            Loader {
                // index 3
                id: pageMatch
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
            Loader {
                // index 4
                id: pageDropdownFill
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
            Loader {
                // index 5
                id: pageTypeInFill
                property string title: active? item.title:"..."
                active: true
                source: "QuestionArea.qml"
                //onLoaded: item.init()
            }
        }
    }


}
