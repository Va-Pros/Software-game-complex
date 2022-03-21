import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Dialogs 1.0
import SituationConstructor 1.0
import QtGraphicalEffects 1.15
import "SituationWidgets" as SW

Kirigami.Page {
    id: page
    title: qsTr("Situation constructor")

    property bool isFileImporting: true
    property string mapPath: ""

    property var itemsToPlace: ({})
    property var selectedCanvasItem: -1

    property bool isMovingNode: false
    property var canvasModel: [{type: "node", subtype: "computer", image: "/icons/computer.png", x: 100, y: 100}]

    ListModel {
        id: selectionModel

        ListElement {
            type: "category"
            name: qsTr("Vertex")
        }
        ListElement {
            type: "node"
            subtype: "computer"
            name: qsTr("Computer")
            image: "/icons/computer.png"
        }
        ListElement {
            type: "node"
            subtype: "router"
            name: qsTr("Router")
            image: "/icons/router.png"
        }
        ListElement {
            type: "node"
            subtype: "commutator"
            name: qsTr("Commutator")
            image: "/icons/commutator.png"
        }
        ListElement {
            type: "node"
            subtype: "server"
            name: qsTr("Server")
            image: "/icons/server.png"
        }
        ListElement {
            type: "divider"
        }
        ListElement {
            type: "category"
            name: qsTr("Edge")
        }
        ListElement {
            type: "edge"
            subtype: "electric"
            name: qsTr("Electric connection")
            color: "tomato"
            image: "/icons/wire.png"
        }

        ListElement {
            type: "edge"
            subtype: "radio"
            color: "darkgray"
            name: qsTr("Radio connection")
            image: "/icons/radio.png"
        }

        ListElement {
            type: "edge"
            subtype: "optical"
            color: "skyblue"
            name: qsTr("Optical connection")
            image: "/icons/optical.png"
        }

        ListElement {
            type: "divider"
        }

        ListElement {
            type: "category"
            name: qsTr("Protection Tools")
        }

        ListElement {
            type: "protection"
            subtype: "OS"
            name: qsTr("Operating System")
            image: "/icons/os.png"
        }

        ListElement {
            type: "protection"
            subtype: "firewall"
            name: qsTr("Firewall")
            image: "/icons/firewall.png"
        }

        ListElement {
            type: "protection"
            subtype: "trustedBoot"
            name: qsTr("Trusted Boot")
            image: "/icons/trustedBoot.png"
        }

        ListElement {
            type: "protection"
            subtype: "intrusionDetection"
            name: qsTr("Intrusion Detection")
            image: "/icons/intrusionDetection.png"
        }

        ListElement {
            type: "protection"
            subtype: "accessControl"
            name: qsTr("Access Control")
            image: "/icons/accessControl.png"
        }
    }

    Controls.ScrollView {
        id: componentsRow
        Controls.ScrollBar.horizontal.policy: Controls.ScrollBar.AlwaysOn
        Layout.fillWidth: true
        Layout.fillHeight: true
        anchors.left: parent.left
        anchors.right: parent.right
        RowLayout {
            Repeater {
                model: selectionModel
                delegate: Component {
                    Loader {
                        Component.onCompleted: {
                            switch (type) {
                                case "divider": {
                                    setSource("SituationWidgets/DividerElement.qml")
                                    break
                                }
                                case "category": {
                                    setSource("SituationWidgets/CategoryElement.qml", {name})
                                    break
                                }
                                default: setSource("SituationWidgets/SelectableElement.qml", {itemData: model})
                            }
                        }
                    }
                }
            }

//            MouseArea {
//                anchors.fill: parent
//                onWheel: {
//                    if (wheel.angleDelta.y > 0) Controls.ScrollBar.horizontal.decrease()
//                    else Controls.ScrollBar.horizontal.increase()
//                }
//            }
        }
    }

    property int canvasItemSize: 96
    property int dropMinX: canvasRectangle.border.width
    property int dropMaxX: canvasRectangle.width - canvasItemSize - canvasRectangle.border.width
    property int dropMinY: canvasRectangle.border.width
    property int dropMaxY: canvasRectangle.height - canvasItemSize - canvasRectangle.border.width



    function ensureInBoundsX(x) {
        return Math.min(Math.max(x, dropMinX), dropMaxX)
    }      

    function ensureInBoundsY(y) {
        return Math.min(Math.max(y, dropMinY), dropMaxY)
    }

    function positionCenterX(x) {
        return ensureInBoundsX(x - canvasRectangle.x - canvasItemSize / 2)
    }

    function positionCenterY(y) {
        return ensureInBoundsY(y - canvasRectangle.y + canvasItemSize / 2)
    }

    Rectangle {
        id: canvasRectangle

        anchors {
            top: componentsRow.bottom
            topMargin: 20
            left: parent.left
            right:  parent.right
            bottom:  bottomRow.top
            bottomMargin: 20
        }

        border.color: "black"
        border.width: 5
        MouseArea {
            id: canvasItemArea
            anchors.fill: parent
            onClicked: function(event){
                if (!isEmpty(itemsToPlace.node)) {

                    const newItem = Object.assign(({}), itemsToPlace.node)
                    newItem.x = positionCenterX(event.x)
                    newItem.y = positionCenterY(event.y)

                    canvasModel.push(newItem);
                    selectedCanvasItem = canvasModel.count - 1
                    canvasModelChanged()
                }
            }
        }
        DropArea {
            id: dragTarget
            anchors.fill: parent

            property bool dropped: false

            onDropped: function (event) {
                console.log("dropped", event.accepted)


                dropped = true
            }

            onExited: {
                dropped = false;
            }
        }

        SW.CanvasComponent {
            id: canvasComponent
        }

        Repeater {
            model: canvasModel
            delegate: canvasComponent
        }

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: canvasRectangle
                    color: "grey"
                }
            }
        ]
    }


    RowLayout {
        id: bottomRow
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Layout.alignment: Qt.AlignRight

        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            folder: shortcuts.home
            nameFilters: [ qsTr("Special Files") + " (*.mlbin)"]
            onAccepted: {
                if (isFileImporting) {
                    SituationModifyHelper.importSituationModel(fileDialog.fileUrl);
                } else {
                    doSave(fileDialog.fileUrl)
                }
            }
        }

        Controls.Button {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Import map")
            icon.name: "document-import"
            onClicked: openFileDialog(true)
        }

        Controls.Button {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Save map")
            icon.name: "document-save"
            onClicked: save()
        }

        Controls.Action {
            shortcut: StandardKey.Save
            onTriggered: save()
        }
    }

    Component {
        id: situationComponent
        SituationModel {}
    }

    function isEmpty(obj) {
        return !obj || (Object.keys(obj).length === 0 && Object.getPrototypeOf(obj) === Object.prototype)
    }

    function openFileDialog(isImporting) {
        isFileImporting = isImporting
        fileDialog.selectExisting = isImporting;
        if (mapPath) {
            fileDialog.folder = mapPath.substring(0, mapPath.lastIndexOf('/'))
        }
        fileDialog.open();
    }

    function save() {
        if (mapPath) { // imported map
            doSave(mapPath)
        } else {
            openFileDialog(false)
        }
    }

    function doSave(path) {
        const model = situationComponent.createObject(null, {name: "test", someData: 7})
        SituationModifyHelper.saveSituationModel(model, path);
    }

    Connections {
        target: SituationModifyHelper
        function onSaved(path) {
            console.log("saved to path: ", path)
        }
        function onImported(situationModel, path) {
            mapPath = path
            console.log("imported:", situationModel.name, "__", situationModel.someData)
        }
    }

}
