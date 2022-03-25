import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.15
import QtQuick.Shapes 1.15

Item {

    property var currentData: canvasModel[index]
    property int sX: currentData.first.x
    property int sY: currentData.first.y
    property int eX: currentData.second.x
    property int eY: currentData.second.y
    property string color: currentData.color

    Shape {
        ShapePath {
            strokeColor: color
            strokeWidth: 5
            startX: sX + 64; startY: sY + 64
            PathLine { x: eX + 64; y: eY + 64 }
        }
    }

    Component.onCompleted: {
        console.log("completed..")
    }

}
