import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    title: qsTr("Game management")

    Label {
        text: qsTr("Game management")
    }

    //Connections {
        ////target: client
        //function onNewMessage(ba) {
            //listModelMessages.append({message: ba + ""})
        //}
    //}

    //ColumnLayout {
        //anchors.fill: parent
////         RowLayout {
////             Layout.fillWidth: true
////             TextField {
////                 id: textFieldIp
////                 placeholderText: qsTr("Server IP")
////                 Layout.fillWidth: true
////                 onAccepted: buttonConnect.clicked()
////             }
////             TextField {
////                 id: textFieldPort
////                 placeholderText: qsTr("Server port")
////                 Layout.fillWidth: true
////                 onAccepted: buttonConnect.clicked()
////             }
////             Button {
////                 id: buttonConnect
////                 text: qsTr("Connect")
////                 onClicked: client.connectToServer(textFieldIp.text, textFieldPort.text)
////             }
////         }
        //ListView {
            //Layout.fillHeight: true
            //Layout.fillWidth: true
            //clip: true
            //model: ListModel {
                //id: listModelMessages
                //ListElement {
                    //message: "Welcome to chat client"
                //}
            //}
            //delegate: ItemDelegate {
                //text: message
            //}
            //ScrollBar.vertical: ScrollBar {}
        //}
        ////RowLayout {
            ////Layout.fillWidth: true
            ////TextField {
                ////id: textFieldMessage
                ////placeholderText: qsTr("Your message ...")
                ////Layout.fillWidth: true
                ////onAccepted: buttonSend.clicked()
            ////}
            ////Button {
                ////id: buttonSend
                ////text: qsTr("Send")
                ////onClicked: {
                    ////client.sendMessage(textFieldMessage.text)
                    ////textFieldMessage.clear()
                ////}
            ////}
        ////}
    //}
}
