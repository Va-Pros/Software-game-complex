import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    title: qsTr("Main menu")

    ColumnLayout {


        Controls.Button {
            text: qsTr("Question constructor")
            onClicked: applicationWindow().pageStack.push("qrc:ui/QuestionConstructor.qml")
        }

        Controls.Button {
            text: qsTr("Situation constructor")
            onClicked: applicationWindow().pageStack.push("qrc:ui/SituationConstructor.qml")
        }

        Controls.Button {
            text: qsTr("Results viewer")
            onClicked: applicationWindow().pageStack.push("qrc:ui/ResultsViewer.qml")
        }

        Controls.Button {
            text: qsTr("Game management")
            onClicked: applicationWindow().pageStack.push("qrc:ui/GameManagement.qml")
        }
    }
}
