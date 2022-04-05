import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

ScrollView {
    id: myListRoot
    contentWidth: availableWidth

    clip: true
    ScrollBar.vertical.policy: ScrollBar.AsNeeded

    required property var model
    required property Component delegate

    ColumnLayout {
        Layout.fillWidth: true
        anchors.left : parent.left
        anchors.right : parent.right
        Repeater {
            model: myListRoot.model
            Layout.fillWidth: true
            delegate: myListRoot.delegate
        }
    }
}
