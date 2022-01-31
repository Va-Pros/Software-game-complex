import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami

Kirigami.ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Admin Panel")

    pageStack.initialPage: Qt.resolvedUrl("MainMenu.qml")
}
