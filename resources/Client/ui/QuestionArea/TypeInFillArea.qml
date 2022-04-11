import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: typeInArea
    property string title: qsTr("Type in fill area")

    property var elements: []


//    Component {
//        id: textComponent
//        Label {
//            text: modelData.text

//            Component.onCompleted: {
//                console.log("baba:", modelData)
//            }
//        }
//    }

//    Component {
//        id: inputComponent
//        TextInput {}
//    }

    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right




        Repeater {
            model: elements
//            delegate: {
//                console.log("dat:", modelData, index)
//                switch (modelData.type) {
//                    case "text": return textComponent
//                    case "input": return inputComponent
//                    default: {
//                        throw `Unknown type '${modelData.type}'`
//                    }
//                }
//            }

            delegate: Component {Loader {
                source: {
                    switch (modelData.type) {
                         case "text": return "FillComponents/TextComponent.qml"
                         case "input": return "FillComponents/InputComponent.qml"
                         default: {
                             throw `Unknown type '${modelData.type}'`
                         }
                     }
                }
            }
            }
        }


        Label {
            id: area
            font.pixelSize: 20
        }
        TextField {
            id: answerField
            Layout.fillWidth: true
            font.pixelSize: 20
            placeholderText: qsTr("Type ans")
            onAccepted: startButton.clicked()
        }
    }

    function init(data) {

        const description = data[3]
        const splitted = description.split("{txt}")
        const newElements = []
        for (let i = 0; i < splitted.length; ++i) {
            if (i > 0) {
                newElements.push({type: "input"})
            }
            newElements.push({type: "text", text: splitted[i]})
        }
        elements = newElements

        console.log("aaaa", description, JSON.stringify(splitted), JSON.stringify(newElements))

        //area.text = `${data[3]}\n${data[5]}`;
    }
}
