import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    minimumWidth: 1024
    minimumHeight: 512
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
         Repeater {
             model: ["GameManagement.qml", "QuestionConstructor.qml", "SituationConstructor.qml", "ResultsViewer.qml"]
             Loader {
                 id: pageGameManagement
//                 property string title: active? item.title:"..."
                 active: true
                 source: modelData
                 //onLoaded: item.init()
             }
         }
    }
}
