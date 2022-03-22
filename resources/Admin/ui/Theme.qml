import QtQuick 2.6
import QtQuick.Controls 2.15

Item {
    property string header
    property var checkThemeTextFieldsAndCountTotal: _checkThemeTextFieldsAndCountTotal
    height: childrenRect.height


    Tag {
        id: tag
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        header: parent.header
    }
    Item {
        anchors.top: tag.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: childrenRect.width
        Label {
            id: easyLabel
            anchors.top: parent.top
            anchors.horizontalCenter: easyTextField.horizontalCenter
            text: qsTr("Easy")
        }
        Label {
            id: mediumLabel
            anchors.top: easyLabel.top
            anchors.horizontalCenter: mediumTextField.horizontalCenter
            text: qsTr("Medium")
        }
        Label {
            id: hardLabel
            anchors.top: mediumLabel.top
            anchors.horizontalCenter: hardTextField.horizontalCenter
            text: qsTr("Hard")
        }
        Label {
            id: totalLabel
            anchors.top: hardLabel.top
            anchors.left: hardTextField.right
            anchors.leftMargin: 10
            text: qsTr("Total")
        }
        ThemeTextField {
            id: easyTextField
            anchors.top: easyLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 100
            height: 30
        }
        ThemeTextField {
            id: mediumTextField
            anchors.top: mediumLabel.bottom
            anchors.topMargin: 10
            anchors.left: easyTextField.right
            anchors.leftMargin: 10
            width: 100
            height: 30
        }
        ThemeTextField {
            id: hardTextField
            anchors.top: hardLabel.bottom
            anchors.topMargin: 10
            anchors.left: mediumTextField.right
            anchors.leftMargin: 10
            width: 100
            height: 30
        }

        Label {
            id: totalCount
            anchors.horizontalCenter: totalLabel.horizontalCenter
            anchors.verticalCenter: hardTextField.verticalCenter
            text: qsTr("0")
        }
    }

    function _checkThemeTextFieldsAndCountTotal() {
        var qmlObjects = [easyTextField, mediumTextField, hardTextField]
        var values = [ {value: 0}, {value: 0}, {value: 0} ]
        var sum = 0
        var result = true
        for (var i = 0; i < qmlObjects.length; i++) {
            if (!isValidInputLowerUpperBounds(qmlObjects[i].text, values[i], 0, 101)) {
                qmlObjects[i].borderColor = "red"
                result = false
            } else {
                qmlObjects[i].borderColor = "black"
                sum += values[i].value
            }
        }
        totalCount.text = sum
        return result
    }
}
