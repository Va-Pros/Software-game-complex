import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Flickable {
    id: flickable

    property string name: "QuestionConstructor"
    property string title: qsTr("Question constructor")

    TabBar {
        id: questionBar
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: 0
        onCurrentIndexChanged: {
            questionSwap.currentIndex = currentIndex
        }
        Repeater {
            model: ["Question creator", "Question editor"]
            TabButton {
                text: modelData
                width: undefined
            }
        }
    }

    SwipeView {
        id: questionSwap
        focus: true
        // anchors.fill: parent
        anchors.top: questionBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: questionBar.currentIndex
        onCurrentIndexChanged: {
            questionBar.currentIndex = currentIndex
        }
        Repeater {
            model: ["QuestionCreator.qml", "QuestionEditor.qml"]
            Loader {
                id: pageQuestionCreator
                property string title: active? item.title:"..."
                active: true
                source: modelData
                //onLoaded: item.init()
            }
        }
    }

}
