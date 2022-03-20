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

        onPositionChanged: function(event) {
            if (drag.active) {
                const inCanvas = mapToItem(canvasRectangle, event.x, event.y)
                currentData["x"] = ensureInBoundsX(inCanvas.x)
                currentData["y"] = ensureInBoundsY(inCanvas.y)
//                currentData = currentData
            }
        }
        onClicked: {

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
                        canvasModel.push({type: "edge", subtype: itemsToPlace.edge, first: canvasModel[(selectedCanvasItem)], second: canvasModel[(thisIndex)]});
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
        onReleased: canvasModelChanged()
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
