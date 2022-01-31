import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami

ColumnLayout {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    Controls.Label {
        text: qsTr("Question text")
    }

    Controls.ScrollView {
        implicitHeight: 200
        anchors.left: parent.left
        anchors.right: parent.right
        Controls.TextArea {
            placeholderText: qsTr("Question text")
        }
    }

    Controls.Label {
        id: answerLabel
        text: qsTr("Answer")
    }

    ColumnLayout {
        id: answersLayout

        RowLayout {

            Controls.RadioButton {
            }

            Controls.TextField {
                placeholderText: qsTr("Answer")
            }
        }
    }

    Controls.Button {
        text: qsTr("Add answer variant")
        onClicked: {
        }
    }
}
