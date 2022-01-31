import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0

Kirigami.ScrollablePage {
    title: qsTr("Question constructor")

    QuestionCreatorModel {
        id: pageModel
    }

    ListView {
        anchors.fill: parent

        model: pageModel.getTypeListModel()
        delegate: Controls.Button {
            required property string title
            required property string ui
            text: title
            onClicked: applicationWindow().pageStack.push("qrc:ui/QuestionEditorPage.qml", {questionType: title, widgetPath: ui})
        }
    }
}
