import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls

Item {

    required property var itemData
    property string type: itemData.type
    property string subtype: itemData.subtype

    implicitWidth: actualContent.width
    implicitHeight: actualContent.height

    states: [
        State {
            when: type !== "edge"
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
        anchors.fill: actualContent
        color: "transparent"
        states: [
            State {
                when: !isEmpty(itemsToPlace)
                          && !isEmpty(itemsToPlace[type])
                          && itemsToPlace[type].subtype === subtype
                PropertyChanges {
                    target: nodeBackground
                    color: "grey"
                }
            }
        ]
    }

    ColumnLayout {
        id: actualContent

        Image {
            id: computerNode
            source: images[subtype]
            sourceSize.width: 32
            sourceSize.height: 32
            horizontalAlignment: Image.AlignHCenter

            Layout.leftMargin: 5
            Layout.rightMargin: 5
            Layout.alignment: Qt.AlignHCenter
        }

        Controls.Label {
            id: label
            text: names[subtype]
            horizontalAlignment: Text.AlignHCenter

            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
        }
    }

    MouseArea {
        id: nodeMouseArea
        anchors.fill: actualContent
        onReleased: function(event) {
            if (type === "protection") {
                const inCanvas = mapToItem(canvasRectangle, event.x, event.y)

                const x = inCanvas.x
                const y = inCanvas.y

                for (const item of canvasModel) {
                    if (item.type !== "node") continue

                    if (item.x <= x && x <= item.x + canvasItemSize && item.y <= y && y <= item.y + canvasItemSize) {
                        item.protection = item.protection || ([]);
                        const toAppend = Object.assign(({}), itemData)
                        item.protection.push(toAppend);
                        canvasModelChanged()
                        break
                    }
                }


                return;
            }
            if (type !== "node") return;
            if (dragTarget.dropped) {
//                const x = Math.min(Math.max(event.x - canvasRectangle.x, dropMinX), dropMaxX)
//                const y = Math.min(Math.max(event.y - canvasRectangle.y, dropMinY), dropMaxY)

                const inCanvas = mapToItem(canvasRectangle, event.x, event.y)

                const x = positionCenterX(inCanvas.x)
                const y = positionCenterY(inCanvas.y)

                const toAppend = Object.assign({x, y}, itemData)
                canvasModel.push(toAppend);
                selectedCanvasItem = canvasModel.count - 1
                dragTarget.dropped = false

                console.log("x:", event.x, event.y)

                canvasModelChanged()
            }
        }
        onClicked: {
            if (itemsToPlace[type] && itemsToPlace[type].subtype === subtype) {
                delete itemsToPlace[type]
            } else {
                itemsToPlace[type] = itemData
            }
            itemsToPlaceChanged()
        }
    }

    Component.onCompleted: {
        console.log("aa", JSON.stringify(Object.keys(itemData)))
    }
}
