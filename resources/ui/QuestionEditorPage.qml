import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami

Kirigami.Page {
    id: editorRoot
    required property string questionType
    required property string widgetPath

    title: questionType

    ColumnLayout {
        id: editorStub
        anchors.top: parent.top
        anchors.bottom: bottomRow.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

//    Loader
//    {
//      id: editorStub
//      anchors.top: parent.top
//      anchors.bottom: parent.bottom
//      anchors.left: parent.left
//      anchors.right: parent.right
//      source: widgetPath
//    }

    RowLayout {
        id: bottomRow
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        layoutDirection: Qt.RightToLeft

        Controls.Button {
            text: "Save"
            icon.name: "document-save"
            onClicked: {
                editorStub.children[0].saveQuestion()
            }
        }
    }

    function finishCreation(comp, compParent) {
        if (comp.status === Component.Ready) {
            comp.createObject(compParent);
        } else if (comp.status === Component.Error) {
            console.log("Error loading component:", comp.errorString());
        }
    }

    Component.onCompleted: {
        const questionEditor = Qt.createComponent(widgetPath, editorStub);
        if (questionEditor.status === Component.Loading) {
            questionEditor.statusChanged.connect(function() { finishCreation(questionEditor, editorStub); });
        } else {
            finishCreation(questionEditor, editorStub);
        }
    }

    Controls.StackView.onActivated: {
        console.log("onActivated");
    }

    Controls.StackView.onActivating: {
        console.log("onActivating");
    }

    Controls.StackView.onDeactivated: {
        console.log("onDeactivated");
    }

    Controls.StackView.onDeactivating: {
        console.log("deactivating");
    }

    Controls.StackView.onRemoved: {
        console.log("removed");
    }
}
