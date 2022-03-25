import QtQuick 2.6
import QtQuick.Controls 2.15

Item {
    property string header

    width: childrenRect.width
    height: childrenRect.height

    Label {
        id: headerLabel
        anchors.left: parent.left
        anchors.top: parent.top
        text: parent.header
    }
    Rectangle {
        id: cross
        anchors.left: headerLabel.right
        anchors.top: headerLabel.top
        anchors.topMargin: -5
        color: "transparent"
        width: 12
        height: 12
        MouseArea {
            id: crossArea
            anchors.fill: parent
            onClicked: onCrossClick(header)
        }
        Rectangle {
            id: first
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width * Math.sqrt(2)
            height: 1
            color: "red"
            radius: width / 2
            transform: Rotation { angle: 45 }
        }
        Rectangle {
            anchors.top: parent.top
            anchors.right: parent.right
            width: first.height
            height: first.width
            color: "red"
            radius: first.radius
            transform: Rotation { angle: 45 }
        }

    }
}
