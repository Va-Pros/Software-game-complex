import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.1
//import CheckableTheme 1.0
import "qrc:/ui"

Page {
    id: gameManager

    property string name: "GameManager"

    Connections {
        target: server
    }

    Label {
        id: titleLabel
        anchors.verticalCenter: titleTextField.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -(titleTextField.width / 2)
        font.pixelSize: 20
        text: qsTr("Title:")
    }
    TextField {
        id: titleTextField
        property string borderColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: titleLabel.right
        anchors.leftMargin: 10
        selectByMouse: true
        width: 300
        height: 30
        font.pixelSize: 20
        placeholderText: qsTr("Enter description")
        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: parent.height
            color: "transparent"
            border.color: parent.borderColor
        }
        onPressed: { borderColor = "black" }
    }

    Label {
        id: testSettingsHeader
        anchors.top: titleTextField.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        font.pixelSize: 30
        text: qsTr("Test settings")
    }

    Label {
        id: chooseThemeLabel
        anchors.verticalCenter: chooseThemeBox.verticalCenter
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Choose a theme:")
    }
    ComboBox {
        id: chooseThemeBox
        anchors.top: testSettingsHeader.bottom
        anchors.topMargin: 10
        anchors.left: chooseThemeLabel.right
        anchors.leftMargin: 10
        width: 300
        height: 30
        model: ListModel {
            id: modelThemes
            ListElement { text: qsTr("Theme 1") }
            ListElement { text: qsTr("Theme 2") }
            ListElement { text: qsTr("Theme 3") }
        }
        onActivated: {
            gridView.model.append({ text: currentValue });
            modelThemes.remove(currentIndex)
        }
    }
    function onCrossClick(theme) {
        modelThemes.append({ text: theme });
        var idx = -1;
        for (var i = 0; i < gridView.model.count; i++) {
            if (gridView.model.get(i).text === theme) {
                idx = i
                break;
            }
        }
        gridView.model.remove(idx)
    }

    Label {
        id: checkeableThemesLabel
        anchors.top: chooseThemeBox.bottom
        anchors.topMargin: 10
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Checkable themes:")
    }

    GridView {
        id: gridView
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: checkeableThemesLabel.bottom
        anchors.topMargin: 10
        interactive: false
        width: parent.width
        height: ((Math.floor(count / 4)) + ((count % 4 === 0) ? 0 : 1)) * 100
        cellWidth: (count > 4) ? (width / 4) : (width / count)
        cellHeight: height / ((Math.floor(count / 4)) + ((count % 4 === 0) ? 0 : 1))

        model: ListModel {}

        delegate: Item {
            property var checkThemeTextFieldsAndCountTotal: theme.checkThemeTextFieldsAndCountTotal
            width: gridView.cellWidth
            height: gridView.cellHeight
            Theme {
                id: theme
                header: text
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
            }
        }
    }

    Label {
        id: satisfactoryLabel
        anchors.top: gridView.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: satisfactory.horizontalCenter
        text: qsTr("3")
    }
    Label {
        id: goodLabel
        anchors.top: satisfactoryLabel.top
        anchors.horizontalCenter: good.horizontalCenter
        text: qsTr("4")
    }
    Label {
        id: excellentLabel
        anchors.top: goodLabel.top
        anchors.horizontalCenter: excellent.horizontalCenter
        text: qsTr("5")
    }

    Label {
        id: numberOfCorrectAnswersLabel
        anchors.verticalCenter: satisfactory.verticalCenter
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Number of correct answers to score:")
    }

    NumberOfCorrectAnswers {
        id: satisfactory
        anchors.left: numberOfCorrectAnswersLabel.right
        anchors.leftMargin: 10
        anchors.top: satisfactoryLabel.bottom
        anchors.topMargin: 5
        defText: qsTr("70")
        label: qsTr("%")
    }
    NumberOfCorrectAnswers {
        id: good
        anchors.left: satisfactory.right
        anchors.leftMargin: 30
        anchors.top: satisfactory.top
        defText: qsTr("80")
        label: qsTr("%")
    }
    NumberOfCorrectAnswers {
        id: excellent
        anchors.left: good.right
        anchors.leftMargin: 30
        anchors.top: good.top
        defText: qsTr("90")
        label: qsTr("%")
    }

    function checkInput() {
        return checkTitle() & checkNumberOfCorrectAnswers() & checkTestTime() & checkGameTime() & checkThemes();
    }

    function checkTitle() {
        if (isEmpty(titleTextField.text)) {
            titleTextField.borderColor = "red"
            return false
        }        return true
    }

    function checkThemes() {
        var result = true
        for (var i = 0; i < gridView.count; i++) {
            if (!gridView.itemAtIndex(i).checkThemeTextFieldsAndCountTotal()) {
                result = false
            }
        }
        return result
    }

    function checkNumberOfCorrectAnswers() {
        var qmlObjects = [satisfactory, good, excellent]
        var values = [ {value: 0}, {value: 0}, {value: 0} ]
        for (var i = 0; i < qmlObjects.length; i++) {
            if (!isValidInputLowerUpperBounds(qmlObjects[i].text, values[i], 1, 101)) {
                qmlObjects[i].borderColor = "red"
                return false;
            }
        }
        for (i = 0; i < qmlObjects.length - 1; i++) {
            if (!(values[i].value < values[i + 1].value)) {
                qmlObjects[i].borderColor = "red"
                qmlObjects[i + 1].borderColor = "red"
                return false;
            }
        }
        return true
    }

    function checkTestTime() {
        var wValue = {value: 0}
        if (!isValidInputLowerBound(testTime.text, wValue, 1)) {
            testTime.borderColor = "red"
            return false;
        }
        return true
    }

    function checkGameTime() {
        var wValue = {value: 0}
        if (!isValidInputLowerBound(gameTime.text, wValue, 1)) {
            gameTime.borderColor = "red"
            return false;
        }
        return true
    }

    function isValidInputLowerUpperBounds(str, wValue, lowerBound, upperBound) {
        return (isDigitOut(str, wValue)) && (wValue.value >= lowerBound) && (wValue.value < upperBound)
    }

    function isValidInputLowerBound(str, wValue, lowerBound) {
        return (isDigitOut(str, wValue)) && (wValue.value >= lowerBound)
    }

    function isDigitOut(str, wValue) {
        wValue.value = parseInt(str, 10);
        return !isNaN(wValue.value)
    }

    function isDigit(str) {
        return !isNaN(parseInt(str, 10))
    }

    function isEmpty(str) {
        return (!str || 0 === str.length);
    }

    Label {
        id: testTimeLabel
        anchors.verticalCenter: testTime.verticalCenter
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Test time:")
    }
    NumberOfCorrectAnswers {
        id: testTime
        anchors.left: testTimeLabel.right
        anchors.leftMargin: 10
        anchors.top: satisfactory.bottom
        anchors.topMargin: 20
        label: qsTr("min")
    }

    Label {
        id: gameSettingsHeader
        anchors.top: testTime.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        font.pixelSize: 30
        text: qsTr("Game settings")
    }
    Label {
        id: situationDifficultyLabel
        anchors.verticalCenter: chooseDifficultyBox.verticalCenter
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Difficulty of the situation:")
    }

    ComboBox {
        id: chooseDifficultyBox
        anchors.top: gameSettingsHeader.bottom
        anchors.topMargin: 10
        anchors.left: situationDifficultyLabel.right
        anchors.leftMargin: 10
        width: 300
        height: 30
        model: ListModel {
            id: modelDifficulty
            ListElement { text: qsTr("Easy") }
            ListElement { text: qsTr("Medium") }
            ListElement { text: qsTr("Hard") }
        }
        onActivated: {
            console.log("Choose ", currentValue)
        }
    }

    Label {
        id: gameTimeLabel
        anchors.verticalCenter: gameTime.verticalCenter
        anchors.right: titleLabel.right
        font.pixelSize: 20
        text: qsTr("Game time:")
    }

    NumberOfCorrectAnswers {
        id: gameTime
        anchors.left: chooseDifficultyBox.left
        anchors.top: chooseDifficultyBox.bottom
        anchors.topMargin: 20
        label: qsTr("min")
    }

    MessageDialog {
        id: alertNotValidInput
        title: qsTr("Invalid input")
        text: qsTr("Incorrect data in red cells")
        Component.onCompleted: visible = false
    }

//    CheckableTheme {
//        id: theme1
//        title: "THEME1"
//        numberOfEasyQuestions: 3
//        numberOfMediumQuestions: 4
//        numberOfHardQuestions: 5
//    }

    Button {
        id: serverAvaliable
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameTime.bottom
        anchors.topMargin: 20
        text: qsTr("Start Server")
        onClicked: {
            if (!checkInput()) {
                alertNotValidInput.open()
            } else {
                sessionSettings.setSettings(titleTextField.text, titleTextField.text, satisfactory.text, good.text,
                                            excellent.text, testTime.text, chooseDifficultyBox.currentIndex, gameTime.text);
                if (!server.isServerAvailable()) {
                    server.onStart()
                    serverAvaliable.text = qsTr("Server Stop")
                } else {
                    server.onStop()
                    serverAvaliable.text = qsTr("Start Server")
                }
            }


        }
    }
}
