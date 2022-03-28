import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Dialogs 1.0

Component {
    Loader {
        source: {
            const type = canvasModel[(index)].type
            switch (type) {
                case "node": return "NodeComponent.qml"
                case "edge": return "EdgeComponent.qml"
                default: throw "Unknown type '" + type + "'"
            }
        }
    }
}
