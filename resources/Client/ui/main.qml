import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    visible: true
    title: qsTr("Client Panel")
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    StackView {
        anchors.fill: parent

        id: mystackview
        initialItem:Qt.resolvedUrl("MainMenu.qml")
    }

    function load_page(pageName, properties = ({})) {
        mystackview.push(`qrc:ui/${pageName}.qml`, properties);
    }
}
