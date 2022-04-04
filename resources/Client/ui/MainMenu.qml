import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15



Page {
    id: mainMenuPage
    title: qsTr("Main menu")

    Connections {
        target: client
        function onConnectedToServer() {
            client.sendMessage("0;" + nameField.text + ";" + platoonField.text)
            load_page("QuestionPage")
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        implicitWidth: 600
        width: 600

        Item {
            Layout.fillWidth: true
            implicitHeight: ipField.height
            Label {
                text: qsTr("IP address:")
                font.pixelSize: 20
                anchors.left: parent.left
            }
            TextField {
                id: ipField
                width: 400
                anchors.right: parent.right
                Layout.fillWidth: true
                text: "127.0.0.1"
                placeholderText: qsTr("127.0.0.1")
                onAccepted: buttonConnect.clicked()
                validator: RegExpValidator {
                    regExp:  /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                //visible: themeAction.text === newThemeAction.text
            }

        }
        Item {
            Layout.fillWidth: true
            implicitHeight: nameField.height
            Label {
                font.pixelSize: 20
                text: qsTr("Name:")
                anchors.left: parent.left
            }
            TextField {
                id: nameField
                width: 400
                anchors.right: parent.right
                Layout.fillWidth: true
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }
        Item {
            Layout.fillWidth: true
            implicitHeight: platoonField.height
            Label {
                text: qsTr("Platoon:")
                font.pixelSize: 20
                anchors.left: parent.left
            }
            TextField {
                id: platoonField
                width: 400
                anchors.right: parent.right
                Layout.fillWidth: true
                onAccepted: startButton.clicked()
                //visible: themeAction.text === newThemeAction.text
            }
        }

        Button {
            id: startButton
            Layout.fillWidth: true
            text: qsTr("Start Test")
            onClicked: {
                if (ipField.acceptableInput)
                   client.connectToServer(ipField.text, "45000")
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
