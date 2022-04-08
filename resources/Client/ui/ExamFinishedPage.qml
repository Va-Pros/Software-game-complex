import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    title: qsTr("Exam finished")

    property string testMark: "Loading..."
    property string gameMark: "Loading..."

    ColumnLayout {
//        anchors.fill: parent
        anchors.centerIn: parent

        Label {
            text: qsTr("Exam finished")
            font.pixelSize: 36
            font.bold: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                text: qsTr("Test mark:")
                font.pixelSize: 20
                font.bold: true
            }

            Label {
                text: testMark
                font.pixelSize: 20
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                text: qsTr("Game mark:")
                font.pixelSize: 20
                font.bold: true
            }

            Label {
                text: gameMark
                font.pixelSize: 20
            }
        }

        Button {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: qsTr("Return to home")
            onClicked: load_page("MainMenu")
        }

        Button {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: qsTr("Exit")
            onClicked: Qt.quit()
        }
    }

    Timer {
        id: fakeLoader
        interval: 2000
        repeat: false
        onTriggered: {
            testMark = "4"
            gameMark = "3"
        }
    }

    Component.onCompleted: {
        fakeLoader.start()
    }
}
