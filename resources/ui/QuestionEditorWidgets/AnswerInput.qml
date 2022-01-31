import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    id: rootLayout
    property var listModel: answerModel
    property bool deleteVisible: true
    width: ListView.view.width - (ListView.view.ScrollBar.vertical && ListView.view.ScrollBar.vertical.visible ? ListView.view.ScrollBar.vertical.width : 0)

    Component {
        id: defaultContent
        RowLayout {
            TextField {
                Layout.fillWidth: true
                text: variant
                placeholderText: qsTr("Variant")
                onEditingFinished: variant = text;
            }
            Button {
                icon.name: "delete"
                visible: listModel.count > 1 && deleteVisible
                onClicked: {
                    listModel.remove(index);
                }
            }
        }
    }

    Component.onCompleted: {
        defaultContent.createObject(rootLayout);
    }
}
