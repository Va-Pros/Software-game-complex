import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QuestionCreator 1.0
import "EditorUtils.js" as EditorUtils
import "AnswerWidgets"

BaseQuestionEditor {

    // TODO rework
    property int maxColumnCount: width < 800 ? 3 : 4
    property int maxListCount: -1
    property int defaultListCount: 1
    property bool modifiable: true
    property string inputFormatting

    function getArrayOfAnswerSubModels() {
        return EditorUtils.mapModel(getAnswerModel(), item => item.listModel);
    }

    function getFirstSubModel() {
        return totalModel.get(0).listModel;
    }

    ListModel {
        id: totalModel
        Component.onCompleted: {
            if (defaultListCount < 1) defaultListCount = 1;
            for (let i = 0; i < defaultListCount; i++) {
                totalModel.append({listModel: [dataItemCreator(true)]})
            }
        }
    }

    Component {
        id: listOfListsDelegate
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop

            property int listIndex: index

            Component {
                id: answerDelegate
                Loader {
                    Layout.fillWidth: true
                    Component.onCompleted: {
                        const properties = answerComponentProperties(listIndex);
                        properties.listModel = listModel
                        setSource(answerQmlFileName, properties);
                    }
                }
            }

            Controls.Label {
                Layout.fillWidth: true
                text: qsTr("Answer list %1").arg(index + 1)
                visible: maxListCount > 1 || maxListCount == -1
            }

            RowLayout {
                Layout.fillWidth: true
                Controls.Button {
                    Layout.fillWidth: true
                    text: qsTr("Add answer variant")
                    onClicked: listModel.append(dataItemCreator(false))
                }
                Controls.Button {
                    Layout.fillWidth: true
                    text: qsTr("Remove list")
                    visible: totalModel.count > 1 && modifiable
                    onClicked: totalModel.remove(listIndex)
                }
            }

            Repeater {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: listModel
                delegate: answerDelegate
            }
        }
    }

    Controls.Button {
        Layout.fillWidth: true
        text: qsTr("Add list")
        visible: maxListCount == -1 || totalModel.count < maxListCount
        onClicked: totalModel.append({listModel: [dataItemCreator(true)]})
    }

    Controls.ScrollView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Controls.ScrollBar.horizontal.policy: Controls.ScrollBar.AlwaysOff
        Controls.ScrollBar.vertical.policy: Controls.ScrollBar.AsNeeded
        contentWidth: availableWidth

        GridLayout {
            anchors.fill: parent
            columns: totalModel.count < maxColumnCount ? totalModel.count : maxColumnCount

            Repeater {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: totalModel
                delegate: listOfListsDelegate
            }

        }
    }


    Component {
        id: hintComponent
        Controls.Label {
            id: hintLabel
            text: inputFormatting
        }
    }

    Component.onCompleted: {
        if (inputFormatting) {
            hintComponent.createObject(getInputLayout());
        }
    }
}
