import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    title: qsTr("Game management")

    Label {
        text: qsTr("Game management")
    }

     Connections {
        target: server
//         function onNewMessage(ba) {
//             listModelMessages.append({message: ba + ""})
//         }
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

    //ColumnLayout {
        //anchors.fill: parent
        //ListView {
            //Layout.fillHeight: true
            //Layout.fillWidth: true
            //clip: true
            //model: ListModel {
                //id: listModelMessages
                //ListElement {
                    //message: "Welcome to chat server"
                //}
            //}
            //delegate: ItemDelegate {
                //text: message
            //}
            //ScrollBar.vertical: ScrollBar {}
        //}
        //RowLayout {
            //Layout.fillWidth: true
            //TextField {
                //id: textFieldMessage
                //placeholderText: qsTr("Your message ...")
                //Layout.fillWidth: true
                //onAccepted: buttonSend.clicked()
            //}
            //Button {
                //id: buttonSend
                //text: qsTr("Send")
                //onClicked: {
                    //server.sendMessage(textFieldMessage.text)
                    //textFieldMessage.clear()
                //}
            //}
        //}
    //}
}
