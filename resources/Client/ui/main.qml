import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Client Panel")

    StackView {
        anchors.fill: parent

        id: mystackview
        initialItem:Qt.resolvedUrl("MainMenu.qml")
    }

    function load_page(pageName) {
        mystackview.push(`qrc:ui/${pageName}.qml`);
    }
}
