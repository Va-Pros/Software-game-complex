import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Flickable {
    id: gameManager

    property string name: "GameManager"
    property string title: qsTr("Game manager")

     Connections {
        target: server
    }

    ColumnLayout {
        anchors.fill: parent
        Button {
            id: serverAvaliable
            Layout.fillWidth: true
            text: qsTr("Start Server")
            onClicked: {
                if (!server.isServerAvailable()) {
                    server.onStart()
                    serverAvaliable.text = qsTr("Server Stop")
                } else {
                    server.onStop()
                    serverAvaliable.text = qsTr("Start Server")
                }
            }
        }
    }
}
