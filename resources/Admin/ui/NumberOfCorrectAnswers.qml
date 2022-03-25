import QtQuick 2.6
import QtQuick.Controls 2.15

Item {
    property string defText
    readonly property string text: _textField.text
    property string label
    property string borderColor: "black"
    property bool _acceptableInput: true
    width: 50
    height: 30

    TextField {
        id: _textField
        selectByMouse: true
        width: 50
        height: 30
        font.pixelSize: 20
        horizontalAlignment: TextField.AlignHCenter
        verticalAlignment: TextField.AlignVCenter
        padding: 0
        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            color: "transparent"
            border.color: borderColor
        }
        onPressed: { borderColor = "black" }

        text: defText
    }
    Label {
        id: _label
        anchors.left: _textField.right
        anchors.leftMargin: 5
        anchors.verticalCenter: _textField.verticalCenter
        font.pixelSize: 15
        text: parent.label
    }
}
