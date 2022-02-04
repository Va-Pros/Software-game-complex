import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    id: rootLayout
    property var listModel: answerModel
    property bool deleteVisible: true
    property var list

    Binding on width {
     when: list !== undefined
     value: (function() {
         if (!list) return undefined;
         return list.width - (list.ScrollBar.vertical && list.ScrollBar.vertical.visible ? list.ScrollBar.vertical.width : 0)
     }());
    }

//    Binding on Layout.fillWidth {
//     when: list === undefined
//     value: true
//    }

    Layout.fillWidth: true

    Component {
        id: defaultContent
        RowLayout {
            Layout.fillWidth: true
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
