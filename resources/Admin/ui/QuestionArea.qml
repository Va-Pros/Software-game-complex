import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13
import Felgo 3.0

Item {
    property string title: qsTr("Question area")
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right
        RowLayout{
            Pane{
                id: themePanel
                contentWidth: Math.max(themeLabel.width, complexityLabel.width, contentLabel.width)
                Label {
                    id:themeLabel
                    text: qsTr("Theme:")
                }
            }
            ComboBox {
                textRole: "text"
                valueRole: "value"
                Layout.fillWidth: true
                Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                editable: true
                model: ListModel {
                    id: themeModel
                    ListElement { text:  qsTr("")}
                    // themeModel.append({text: theme[idx]})
                }
            }
        }
        RowLayout {
            id: complexityRow
            Pane{
                contentWidth: themePanel.contentWidth
                Label {
                    id:complexityLabel
                    text: qsTr("Complexity:")
                }
            }
            RadioButton {
                text:  qsTr("Easy")
                checked: true
            }
            RadioButton {
                text:  qsTr("Medium")
            }
            RadioButton {
                text:  qsTr("Hard")
            }
        }
        RowLayout {
            Pane{
                contentWidth: themePanel.contentWidth
                Label {
                    id:contentLabel
//                     anchors.top: parent.bottom
                    text: qsTr("Content:")
                }
            }

            Item {
                id: editorRoot

                // line height and line count of text edit
                readonly property real lineHeight: (textEdit.implicitHeight - 2 * textEdit.textMargin) / textEdit.lineCount
                readonly property alias lineCount: textEdit.lineCount

                // ...

                Column {
                    // start position of line numbers depends on text margin
                    y: textEdit.textMargin
                    width: parent.width

                // add line numbers based on line count and height
                    Repeater {
                    model: editorRoot.lineCount
                    delegate: Text {
                        id: text
                        width: implicitWidth
                        height: editorRoot.lineHeight
                        color: "#666"
                        font: textEdit.font
                        text: index + 1
                    }
                    }
                }

                // ...

                AppTextEdit {
                    id: textEdit

                    property int currentLine: text.substring(0, cursorPosition).split(/\r\n|\r|\n/).length - 1
                    textMargin: 30
                    wrapMode: Text.WordWrap
                    anchors {
                    fill: parent
                    topMargin: 2
                    leftMargin: numbersColumnWidth + 10
                    }
                    selectByKeyboard: true
                    selectByMouse: true
                    textFormat: Qt.PlainText
                    verticalAlignment: TextEdit.AlignTop
                }

                // ...
                }
        }

    }
}
