import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.15

Item {

    property var currentData: canvasModel[(index)]
    property var thisIndex: index

    Item {
        id: visiblePart
        implicitWidth: canvasItemSize
        implicitHeight: canvasItemSize
        x: currentData.x
        y: currentData.y

        Image {
            id: canvasItem
            source: Qt.resolvedUrl(images[currentData.subtype])
            sourceSize.width: canvasItemSize
            sourceSize.height: canvasItemSize

        }

        ColorOverlay {
            id: canvasItemOverlay
            anchors.fill: canvasItem
            source: canvasItem
            color: "transparent"
            states: [
                State {
                    when: componentArea.drag.active
                    PropertyChanges {
                        target: canvasItemOverlay
                        color: "gold"
                    }
                },
                State {
                    when: selectedCanvasItem === index
                    PropertyChanges {
                        target: canvasItemOverlay
                        color: "orange"
                    }
                }
            ]
        }

        Image {
            id: protectionToolsIcon
            source: Qt.resolvedUrl("/icons/protectionLogo.png")
            visible: !isEmpty(currentData.protection) && currentData.protection.length > 0
            sourceSize.width: 24
            sourceSize.height: 24
            z: 10
            x: canvasItemSize - sourceSize.width
            Controls.ToolTip.text: isEmpty(currentData.protection) ? "" : currentData.protection.reduce((acc, p) => acc + names[p.subtype] + "; ", "")
            Controls.ToolTip.visible: visible && componentArea.containsMouse
        }
    }

    MouseArea {
        id: componentArea
        anchors.fill: visiblePart
        drag.target: visiblePart
        drag.minimumX: dropMinX
        drag.maximumX: dropMaxX
        drag.minimumY: dropMinY
        drag.maximumY: dropMaxY

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        onClicked: {
            console.log("button", mouse.button)
            switch (mouse.button) {
                case Qt.LeftButton:

                    if (itemsToPlace.protection) {
                        currentData.protection = currentData.protection || ([]);
                        currentData.protection.push(itemsToPlace.protection);
                        canvasModelChanged()
                        return;
                    }

                    if (selectedCanvasItem === thisIndex) {
                        console.log("drop")
                        selectedCanvasItem = null
                    } else if (selectedCanvasItem < 0 || selectedCanvasItem == null) {
                        console.log("new")
                        selectedCanvasItem = thisIndex
                    } else if (itemsToPlace.edge && selectedCanvasItem) {
                        console.log("connecting", selectedCanvasItem, "and", (thisIndex))
                        const toAppend = Object.assign({first: canvasModel[selectedCanvasItem], second: canvasModel[thisIndex]}, itemsToPlace.edge)
                        canvasModel.push(toAppend)
                        selectedCanvasItem = null
                        canvasModelChanged()
                    } else {
                        selectedCanvasItem = thisIndex
                    }

                    console.log(thisIndex, selectedCanvasItem)
                    break;
                case Qt.RightButton:
                    contextMenu.popup()
                    break;
            }
        }
        onReleased: function(event) {
            if (drag.active) {
                const inCanvas = mapToItem(canvasRectangle, event.x, event.y)
                currentData["x"] = inCanvas.x - event.x
                currentData["y"] = inCanvas.y - event.y
                console.log("pos:", currentData["x"], currentData["y"])
                canvasModelChanged()
            }
        }
    }

    Controls.Menu {
        id: contextMenu
        Controls.MenuItem {
            text: "Remove"
            onTriggered: {
                const removed = canvasModel[index]
                canvasModel.splice(index, 1)
                canvasModel = canvasModel.filter(item => item.type !== "edge" || (item.first !== removed && item.second !== removed));
            }
        }
    }
}
