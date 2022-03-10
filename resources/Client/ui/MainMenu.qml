import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0



Kirigami.Page {
    id: mainMenuPage
    title: qsTr("Main menu")

    Connections {
        target: client
    }

    ColumnLayout {
        anchors.left : parent.left
        anchors.right : parent.right

        RowLayout {
            Layout.fillWidth: true
            Controls.Label {
                text: qsTr("ip:")
            }
            Controls.TextField {
                id: ipField
                Layout.fillWidth: true
                placeholderText: qsTr("127.0.0.1")
                onAccepted: buttonConnect.clicked()
                validator: RegExpValidator {
                    regExp:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                //visible: themeAction.text === newThemeAction.text
            }
            Controls.Button {
            id: buttonConnect
            Layout.fillWidth: true
            text: qsTr("check connection")
            onClicked: {
                console.log("connenting to " + ipField.displayText + ":45000");
                if (ipField.acceptableInput)
                    client.connectToServer(ipField.text, "45000")
            }
        }

        }
        RowLayout {
            Layout.fillWidth: true
                Controls.Label {
                text: qsTr("name:")
            }
            Controls.TextField {
                id: nameField
                Layout.fillWidth: true
                placeholderText: qsTr("Семенов Максим Алексеевич")
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }
        RowLayout {
            Layout.fillWidth: true
                Controls.Label {
                text: qsTr("platoon:")
            }
            Controls.TextField {
                id: platoonField
                Layout.fillWidth: true
                placeholderText: qsTr("Самый лучший в мире!")
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }

        Controls.Button {
            id: startButton
            Layout.fillWidth: true
            text: qsTr("Start Test")
            onClicked: {
                if (client.isConnected()) {
                    client.sendMessage(nameField.text + " " + platoonField.text)
                    applicationWindow().pageStack.push("qrc:ui/GameManagement.qml")
                }
            }
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
