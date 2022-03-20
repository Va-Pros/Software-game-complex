import QtQuick 2.0

Rectangle {
    implicitWidth: 5
    implicitHeight: 56
    anchors {
        topMargin: 20
        leftMargin: 100
        rightMargin: 10
    }

    color: "black"
    Component.onCompleted: {
        console.log("divider")
    }
}
