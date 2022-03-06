import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0

Kirigami.Page {
    id: mainMenuPage
    title: qsTr("Main menu")

    ColumnLayout {
        anchors.left : parent.left
        anchors.right : parent.right

        Controls.TextField {
            id: ipField
            Layout.fillWidth: true
            placeholderText: qsTr("ip")
            visible: themeAction.text === newThemeAction.text
        }

        Controls.TextField {
            id: nameField
            Layout.fillWidth: true
            placeholderText: qsTr("name")
            visible: themeAction.text === newThemeAction.text
        }

        Controls.TextField {
            id: platoonField
            Layout.fillWidth: true
            placeholderText: qsTr("vzvod:)")
            visible: themeAction.text === newThemeAction.text
        }

        Controls.Button {
            Layout.fillWidth: true
            text: qsTr("Start Test")
            onClicked: applicationWindow().pageStack.push("qrc:ui/GameManagement.qml")
        }


    }

    Controls.StackView.onActivated: {
        console.log("onActivated");
    }

    Controls.StackView.onActivating: {
        console.log("onActivating");
    }

    Controls.StackView.onDeactivated: {
        console.log("onDeactivated");
    }

    Controls.StackView.onDeactivating: {
        console.log("deactivating");
    }

    Controls.StackView.onRemoved: {
        console.log("removed");
    }
}
