import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.15

Item {

    property var currentData: canvasModel[(index)]
    property var thisIndex: index

    Image {
        id: canvasItem
        source: Qt.resolvedUrl(currentData.image.toString())
        sourceSize.width: canvasItemSize
        sourceSize.height: canvasItemSize
        x: currentData.x
        y: currentData.y

    }

    MouseArea {
        id: componentArea
        anchors.fill: canvasItem
        drag.target: canvasItem
        drag.minimumX: dropMinX
        drag.maximumX: dropMaxX
        drag.minimumY: dropMinY
        drag.maximumY: dropMaxY

        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: {
            console.log("button", mouse.button)
            switch (mouse.button) {
                case Qt.LeftButton:
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
