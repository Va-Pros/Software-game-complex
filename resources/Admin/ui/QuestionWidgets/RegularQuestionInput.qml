import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

ColumnLayout {

    function getText() {
        return inputArea.text;
    }

    function setText(text) {
        inputArea.text = text;
    }

    Label {
        text: qsTr("Question text")
    }

    TextArea {
        id: inputArea
        implicitHeight: 100
        Layout.fillWidth: true
        placeholderText: qsTr("Question text")
    }

    Action {
        shortcut: "Ctrl+Shift+Q"
        onTriggered: {
            inputArea.focus = true
        }
    }

}
