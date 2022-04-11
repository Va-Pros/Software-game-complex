import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: placerRoot

    onChildrenChanged: updatePreferredSizes()
    onWidthChanged: updatePreferredSizes()
    onHeightChanged: updatePreferredSizes()

    function updatePreferredSizes() {
        if (visibleChildren.length === 0) return

        let previousChild = visibleChildren[0]
        previousChild.anchors.left = placerRoot.left

        for (let i = 1; i < visibleChildren.length; ++i) {
            const currentChild = visibleChildren[i]
            console.log("ch:", i, " : ", currentChild)
            currentChild.anchors.left = previousChild.anchors.right
        }

    }

}
