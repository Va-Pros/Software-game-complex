import QtQuick 2.6
import QtQuick.Controls 2.15

Item {
    property string borderColor: "black"
    readonly property string text: _textField.text
    TextField {
        id: _textField
        anchors.fill: parent
        selectByMouse: true
        font.pixelSize: 20
        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            color: "transparent"
            border.color: borderColor
        }
        onPressed: { borderColor = "black" }
        onEditingFinished: _checkThemeTextFieldsAndCountTotal()
    }
}
