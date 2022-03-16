import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Admin Panel")

    TabBar {
        id: mainBar
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: 0
        onCurrentIndexChanged: {
            mainSwap.currentIndex = currentIndex
        }
        Repeater {
            model: ["Game management", "Question constructor", "Situation constructor", "Results viewer"]
            TabButton {
                text: modelData
                width: undefined
            }
        }
    }

    SwipeView {
        id: mainSwap
        focus: true
        anchors.top: mainBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: mainBar.currentIndex
        onCurrentIndexChanged: {
            mainBar.currentIndex = currentIndex
        }

        Loader {
            // index 0
            id: pageGameManagement
            property string title: active? item.title:"..."
            active: true
            source: "GameManagement.qml"
            //onLoaded: item.init()
        }
        Loader {
            // index 1
            id: pageQuestionConstructor
            property string title: active? item.title:"..."
            active: true
            source: "QuestionConstructor.qml"
            //onLoaded: item.init()
        }
        Loader {
            // index 2
            id: pageSituationConstructor
            property string title: active? item.title:"..."
            active: true
            source: "SituationConstructor.qml"
            //onLoaded: item.init()
        }
        Loader {
            // index 3
            id: pageResultsViewer
            property string title: active? item.title:"..."
            active: true
            source: "ResultsViewer.qml"
            //onLoaded: item.init()
        }
    }
}
