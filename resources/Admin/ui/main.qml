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
            sectionLoader.source = getFileNameByIndex(currentIndex)
        }
        Repeater {
            model: ["Game management", "Question constructor", "Situation constructor", "Results viewer"]
            TabButton {
                text: modelData
                width: undefined
            }
        }
    }

    Loader {
        id: sectionLoader
        anchors.top: mainBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        // property string title: active ? item.title: "..."
        active: true
        source: "GameManagement.qml"
        //onLoaded: item.init()
    }

    function getFileNameByIndex(idx) {
        switch (idx) {
            case 0: return "GameManagement.qml"

            case 1: return "QuestionConstructor.qml"

            case 2: return "SituationConstructor.qml"

            case 3: return "ResultsViewer.qml"

            default: return null
        }
    }

}
