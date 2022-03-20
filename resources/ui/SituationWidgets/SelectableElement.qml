import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami

Item {

    required property string type
    required property string subtype
    required property string iconSource

    implicitWidth: computerNode.width
    implicitHeight: computerNode.height

    states: [
        State {
            when: type === "node"
            PropertyChanges {
                target: computerNode
                z: nodeMouseArea.drag.active || nodeMouseArea.pressed ? 2 : 1
                Drag.active: nodeMouseArea.drag.active
                Drag.supportedActions: Qt.CopyAction
                Drag.dragType: Drag.Automatic
            }
            PropertyChanges {
                target: nodeMouseArea
                drag.target: parent
            }
        }
    ]

    Rectangle {
        id: nodeBackground
        anchors.fill: computerNode
        color: "transparent"
        states: [
            State {
                when:
                    !isEmpty(itemsToPlace)
                      && itemsToPlace[type]
                      && itemsToPlace[type].subtype === subtype
                PropertyChanges {
                    target: nodeBackground
                    color: "grey"
                }
            }
        ]
    }

    Image {
        id: computerNode
        source: iconSource
        sourceSize.width: 64
        sourceSize.height: 64

        MouseArea {
            id: nodeMouseArea
            anchors.fill: parent
            onReleased: function(event) {
                if (type !== "node") return;
                if (dragTarget.dropped) {
                    const x = Math.min(Math.max(event.x - canvasRectangle.x, dropMinX), dropMaxX)
                    const y = Math.min(Math.max(event.y - canvasRectangle.y, dropMinY), dropMaxY)
                    canvasModel.push({type: type, subtype: subtype, image: iconSource, x: x, y: y});
                    selectedCanvasItem = canvasModel.count - 1
                    dragTarget.dropped = false

                    console.log("dropping at: ", event.x, event.y, JSON.stringify(canvasModel))
                    canvasModelChanged()
//                    onCanvasModelChanged.connect(test)
//                    onCanvasModelChanged = test
//                    onCanvasModelChanged()
//                    for (const a in onCanvasModelChanged) {
//                        console.log(a)
//                    }
                }
            }
            onClicked: {
                if (itemsToPlace[type] && itemsToPlace[type].subtype === subtype) {
                    delete itemsToPlace[type]
                } else {
                    itemsToPlace[type] = ({type, subtype, image: iconSource})
                }
                console.log(JSON.stringify(itemsToPlace))
            }
        }

    }

    function test() {
        console.log("aaaaaaaaaaa")
    }
}
