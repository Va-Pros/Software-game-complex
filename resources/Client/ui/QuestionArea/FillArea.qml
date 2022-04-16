import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "." as CC

Pane {
    id: typeInArea
    property string title: qsTr("Fill area")
    property var elements: []

    TextMetrics {
        id: spaceMetrics
        text: " "
        font: txt.font
    }


    Repeater {
        id: rptr
        model: elements.filter(it => it.type !== "text")
        delegate: Loader {
            source: {
                switch (modelData.type) {
                    //case "text": return "FillComponents/TextComponent.qml"
                    case "input": return "FillComponents/InputComponent.qml"
                    case "dropdown": return "FillComponents/DropDownComponent.qml"
                    default: {
                        throw `Unknown type '${modelData.type}'`
                    }
                }
            }
        }

        onModelChanged: {

            placeFillItems()
        }
    }

    property bool done : false

    //CC.FillItemPlacer {
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right

        onWidthChanged: {
            //placeFillItems()
        }

        Text {
            id: txt
            Layout.fillWidth: true
            text: elements.filter(it => it.type === "text").map(it => it.text).join('')
            wrapMode: Text.Wrap
            lineHeight: 50
            lineHeightMode: Text.FixedHeight
            onLineLaidOut: {
                //console.log("line: ", JSON.stringify(line))
            }

            Component.onCompleted: {


            }

            onTextChanged: {
                if (done) return;
                done = true


            }
            textFormat: Text.PlainText


        }
    }

    function insertText(where, what, offset) {
        return where.substring(0, offset) + what + where.substring(offset);
    }

    function findOffsetLocation(label, offset) {
        let x = -1
        let y = -1

        const originalText = label.text
        const textToMeasure = originalText.substring(0, offset)

        if (originalText === textToMeasure) {
            label.text = originalText + ";" // ensure text changes
        }

        let finder = function(line) {
            console.log("dd: ", JSON.stringify(line))
            if (line.isLast) {
                x = line.implicitWidth - 10
                y = line.y
            }
        }

        label.lineLaidOut.connect(finder)
        const newText = textToMeasure
        console.log("newText:", newText)
        label.text = newText
        label.lineLaidOut.disconnect(finder)
        label.text = originalText
        return Qt.point(x, y)
    }

    function placeFillItems() {

        //txt.text = elements.filter(it => it.type === "text").map(it => it.text).join('')

        let offset = 0
        let index = 0

        let x = 0
        let y = 0

        let placed = 0
        let lastPlaced = false

        for (const elem of elements) {

            if (elem.type === "text") {

                const str = elem.text
                console.log("str:", str)

                //if (countrptr.children)
                if (lastPlaced) {
                    const item = rptr.itemAt(placed - 1).item

                    spaceMetrics.font = item.font
                    console.log("metrics:", spaceMetrics.width, spaceMetrics.advanceWidth, spaceMetrics.elideWidth, JSON.stringify(spaceMetrics.boundingRect), JSON.stringify(spaceMetrics.tightBoundingRect))
                    const count = Math.ceil(item.width / spaceMetrics.advanceWidth)// + 4

                    txt.text = insertText(txt.text, " ".repeat(count), offset)

                    offset += count

                    console.log("prepl:", item.width, count)
                }

                if (index === elements.length - 1) break;

                offset += str.length
                const loc = findOffsetLocation(txt, offset)
                console.log(`End of '${str}' is ${loc.x};${loc.y}'`)

                x = loc.x
                y = loc.y


                lastPlaced = false
            } else {

                const item = rptr.itemAt(placed).item

                if (x < 0 || y < 0) {
                    //item.visible = false
                    continue;
                }

                const pt = typeInArea.mapFromItem(txt, x, y)
                //const pt = Qt.point(x, y)
                console.log("place at: ", pt.x, pt.y, x, y)

                item.x = pt.x
                item.y = pt.y - (item.height / 2)

                placed++
                lastPlaced = true
            }

            index++
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
