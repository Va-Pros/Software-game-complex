import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "." as CC

Pane {
    id: typeInArea
    property string title: qsTr("Fill area")
    property var elements: []


    //CC.FillItemPlacer {
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right

        Repeater {
            model: elements

            delegate: Loader {
                source: {
                    switch (modelData.type) {
                        case "text": return "FillComponents/TextComponent.qml"
                        case "input": return "FillComponents/InputComponent.qml"
                        case "dropdown": return "FillComponents/DropDownComponent.qml"
                        default: {
                            throw `Unknown type '${modelData.type}'`
                        }
                    }
                }
            }
        }
    }

    function init(data) {

        const description = data[3]
        const type = data[4]
        const splitted = description.split("{txt}")
        const newElements = []
        for (let i = 0; i < splitted.length; ++i) {
            if (i > 0) {
                if (type == 4) { //dropdown fill
                    newElements.push({type: "dropdown", variants: data[5][i - 1]})
                } else if (type == 5) {
                    newElements.push({type: "input"})
                } else {
                    console.log("ghm:", type)
                }
            }

            newElements.push({type: "text", text: splitted[i]})
        }

        elements = newElements
    }
}
