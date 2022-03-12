import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0

Kirigami.ScrollablePage {
    title: qsTr("Question constructor")
    Layout.leftMargin: 40

    QuestionCreatorModel {
        id: pageModel
    }

    ListView {
        anchors.left : parent.left
        anchors.right : parent.right
        anchors.margins: 20

        model: pageModel.getTypeListModel()
        delegate: Controls.Button {
            required property string title
            required property string ui
            anchors.left : parent.left
            anchors.right : parent.right

            text: title
            onClicked: applicationWindow().pageStack.push("qrc:ui/QuestionEditorPage.qml", {questionType: title, widgetPath: ui})
        }
    }
}
