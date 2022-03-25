import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15



Page {
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
            Label {
                text: qsTr("ip:")
            }
            TextField {
                id: ipField
                Layout.fillWidth: true
                placeholderText: qsTr("127.0.0.1")
                onAccepted: buttonConnect.clicked()
                validator: RegExpValidator {
                    regExp:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                //visible: themeAction.text === newThemeAction.text
            }
            Button {
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
                Label {
                text: qsTr("name:")
            }
            TextField {
                id: nameField
                Layout.fillWidth: true
                placeholderText: qsTr("Семенов Максим Алексеевич")
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }
        RowLayout {
            Layout.fillWidth: true
                Label {
                text: qsTr("platoon:")
            }
            TextField {
                id: platoonField
                Layout.fillWidth: true
                placeholderText: qsTr("Самый лучший в мире!")
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }

        Button {
            id: startButton
            Layout.fillWidth: true
            text: qsTr("Start Test")
            onClicked: {
                if (client.isConnected()) {
                    client.sendMessage("0;" + nameField.text + ";" + platoonField.text)
                    load_page("QuestionPage")
                }
            }
        }

    }
/*
    StackView.onActivated: {
        console.log("onActivated");
    }

    StackView.onActivating: {
        console.log("onActivating");
    }

    StackView.onDeactivated: {
        console.log("onDeactivated");
    }

    StackView.onDeactivating: {
        console.log("deactivating");
    }

    StackView.onRemoved: {
        console.log("removed");
    }*/
}
