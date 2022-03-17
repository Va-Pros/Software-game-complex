import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13
import org.kde.kirigami 2.4 as Kirigami

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
                    font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
                }
                Repeater {
                    model: ListModel {
                        ListElement { index:1; title: qsTr("Single choice")}
                        ListElement { index:2; title: qsTr("Multiple choice")}
                        ListElement { index:3; title: qsTr("Type in")}
                        ListElement { index:4; title: qsTr("Match")}
                        ListElement { index:5; title: qsTr("Dropdown fill")}
                        ListElement { index:6; title: qsTr("Type in fill")}
                    }
                    Button {
                        required property string title
                        required property int index
                        Layout.fillWidth: true
                        text: title
                        onClicked: questionCreatorSwap.currentIndex = index
                        flat: questionCreatorPanel.index != index
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
                    //onLoaded: item.init()
                }
            }
        }
    }


}
