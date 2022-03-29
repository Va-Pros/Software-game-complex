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
                visible: false
            }
            TextField {
                id: ipField
                Layout.fillWidth: true
                text: "127.0.0.1"
                placeholderText: qsTr("127.0.0.1")
                onAccepted: buttonConnect.clicked()
                validator: RegExpValidator {
                    regExp:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                //visible: themeAction.text === newThemeAction.text
                visible: false
            }
            Button {
            id: buttonConnect
            Layout.fillWidth: true
            text: qsTr("check connection")
            visible: false
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
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }


            Button {
            id: connectButton
            Layout.fillWidth: true
            text: qsTr("Connect")
            onClicked: {
                if (ipField.acceptableInput)
                   client.connectToServer(ipField.text, "45000")
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
