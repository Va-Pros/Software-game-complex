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

    Flickable {
        id: flickable
        //anchors.fill: parent
        Layout.preferredHeight: 200
        Layout.fillWidth: true

        TextArea.flickable: TextArea {
            id: inputArea


            wrapMode: TextEdit.Wrap
            placeholderText: qsTr("Question text")
        }

        ScrollBar.vertical: ScrollBar { }
    }

    Action {
        shortcut: "Ctrl+Shift+Q"
        onTriggered: {
            inputArea.focus = true
        }
    }

}
