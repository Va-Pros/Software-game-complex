import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.13

Pane {
    id: questionArea
    property string title: qsTr("Question area")
    property int id: -1
    property bool is_deleted: false
    property int type: 2
    property var answers_list:[]
    property var is_correct:[]
    property var singleChoiceIdx:[]
    Connections {
        target: database
    }
    ColumnLayout {
        id: questionAreaPanel
        anchors.left : parent.left
        anchors.right : parent.right
        RowLayout{
            Pane{
                id: themePanel
                contentWidth: Math.max(themeLabel.width, difficultyLabel.width, contentLabel.width)
                Label {
                    id:themeLabel
                    text: qsTr("Theme:")
                }
            }
            ComboBox {
                id : themeName
                textRole: "text"
                valueRole: "value"
                Layout.fillWidth: true
                Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                editable: true
                model: ListModel {
                    id: themeModel
                    ListElement { text:  qsTr("")}
                    // themeModel.append({text: theme[idx]})
                }
            }
        }
        RowLayout {
            id: difficultyRow
            property int activeIdx: 0
            Pane{
                contentWidth: themePanel.contentWidth
                Label {
                    id:difficultyLabel
                    text: qsTr("Difficulty:")
                }
            }
            Repeater {
                //Layout.fillWidth: true
                //Layout.maximumWidth: Qt.application.screens[0].width * 0.42
                model: [qsTr("Easy"),  qsTr("Medium"), qsTr("Hard")]
                RadioButton {
                    text:modelData
                    checked: index==difficultyRow.activeIdx
                    onClicked: difficultyRow.activeIdx=index
                }
            }
        }
        Pane {
            Layout.fillWidth: true
            ColumnLayout {
                anchors.fill: parent
                Label {
                    id:contentLabel
                    text: qsTr("Content:")
                }

                TextArea {
                    id:descriptionArea
                    Layout.fillWidth: true
                    Layout.minimumHeight: themeName.height * 2
                    placeholderText: qsTr("Enter description")
                }
            }
        }
        RowLayout{
            Repeater {
                id:listModel
                model:answers_list.length
                //required property int index
                Pane{
                    Layout.fillWidth: true
                    ColumnLayout{
                        id:answerList
                        property int topIndex:index
                        anchors.fill: parent
                        Label {
                            text: qsTr(`Answer options${answers_list.length>1?` {${answerList.topIndex}}`:""}:`)
                        }
                        ButtonGroup {
                            id: singleChoiceGroup
                        }
                        Repeater {
                            id: answersModel
                            model: answers_list[answerList.topIndex].length
                            RowLayout {
                                RadioButton{
                                    ButtonGroup.group: singleChoiceGroup
                                    checked:singleChoiceIdx[answerList.topIndex] == index
                                    onCheckedChanged: {
                                        if(singleChoiceIdx[answerList.topIndex] != index){
                                            is_correct[answerList.topIndex][singleChoiceIdx[answerList.topIndex]]=false;
                                            is_correct[answerList.topIndex][index]=true;
                                            singleChoiceIdx[answerList.topIndex] = index;
                                            console.log(112, id, singleChoiceIdx);
                                            //updateLocalModel(answersModel.model, answers_list[answerList.topIndex].length);
                                            updateModel();
                                            //answersModel.model++;
                                            //answersModel.model--;
                                        }
                                    }
                                    visible: (questionArea.type%4)==0
                                }
                                CheckBox{
                                    checked:is_correct[answerList.topIndex][index]
                                    onCheckedChanged: is_correct[answerList.topIndex][index]=checked
                                    visible: questionArea.type==1
                                }
                                TextField{
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                    text:answers_list[answerList.topIndex][index]
                                    onEditingFinished:{
                                        answers_list[answerList.topIndex][index] = text;
                                    }
                                }
                                Button {
                                    id: del_ans
                                    icon.name: "delete"
                                    visible: answersModel.model > 1&&singleChoiceIdx[answerList.topIndex]!=index&&
                                                    (type!=3||answerList.topIndex!=1||answers_list[0].length<answers_list[1].length)
                                    onClicked: {
                                        answers_list[answerList.topIndex].splice(index, 1);
                                        is_correct[answerList.topIndex].splice(index, 1);
                                        answersModel.model--;
                                    }
                                }
                            }
                        }
                        RowLayout{
                            Button {
                                Layout.fillWidth: true
                                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                Layout.alignment: Qt.AlignLeft
                                text: qsTr("Add option")
                                icon.name: "list-add"
                                onClicked: {
                                    answers_list[answerList.topIndex].push(qsTr(""));
                                    is_correct[answerList.topIndex].push((questionArea.type%4)!=0);
                                    if(questionArea.type==3&&answerList.topIndex==0&&answers_list[0].length>answers_list[1].length){
                                        answers_list[1].push(qsTr(""));
                                        is_correct[1].push(true);
                                        updateModel();
                                    }
                                    answersModel.model++;
                                }
                            }
                            Button {
                                Layout.fillWidth: true
                                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                                Layout.alignment: Qt.AlignLeft
                                text: qsTr("Delete list")
                                icon.name: "delete"
                                visible:answers_list.length>1&&type>3
                                onClicked: {
                                    answers_list.splice(answerList.topIndex, 1);
                                    is_correct.splice(answerList.topIndex, 1);
                                    listModel.model--;
                                }
                            }
                        }
                    }
                }
            }
            Button {
                Layout.fillWidth: true
                Layout.maximumWidth: Qt.application.screens[0].width * 0.42 + themePanel.contentWidth
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Add list")
                icon.name: "list-add"
                visible:questionArea.type>3
                onClicked: {
                    answers_list.push([qsTr("")]);
                    is_correct.push([true]);
                    singleChoiceIdx.push(type%4==0?0:-1);
                    listModel.model++;
                }
            }
        }
        RowLayout {
            Button {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft
                text: id>0?(is_deleted?qsTr("Restore"):qsTr("Delete")):qsTr("Clear")
                icon.name: "delete"
                onClicked: {
                    is_deleted=!is_deleted;
                    updateDB();
                    if(id<0)
                        init(questionArea.type);
                }
            }

            Button {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                text: qsTr("Save")
                icon.name: "document-save"
                onClicked: {
                    updateDB();
                    if(id<0)
                        init(questionArea.type);
                }
            }
        }
    }
    function updateDB(){
        database.insertORUpdateIntoQuestionTable(id, themeName.editText, difficultyRow.activeIdx, descriptionArea.text, questionArea.type, answers_list, is_correct, is_deleted);
    }
    function updateModel(){
        listModel.model=0;
        listModel.model=answers_list.length;
    }
    function init(type) {
        //themeModel.append({text: qsTr("123")});
        themeName.editText=qsTr("");
        descriptionArea.text=qsTr("");
        questionArea.type=type;
        answers_list=[[qsTr("")]];
        difficultyRow.activeIdx=0;
        is_correct= [[true]];
        singleChoiceIdx= [type%4==0?0:-1];
        if(type==3){
            answers_list.push([qsTr("")]);
            is_correct.push([true]);
            singleChoiceIdx.push(type%4==0?0:-1);
        }
        updateModel();
    }
    function initFromArray(data){
        if(!data.length)return false;
        //console.log(data);
        id = data[0]-0;
        themeName.editText = qsTr(data[1]);
        difficultyRow.activeIdx = data[2]-0;
        descriptionArea.text = qsTr(data[3]);
        questionArea.type=data[4]-0;
        answers_list=data[5];
        is_correct=data[6];
        for(var i=0;i<is_correct.length;i++)
            for(var j=0;j<is_correct[i].length;j++)
                if(is_correct[i][j]||type%4!=0){
                    singleChoiceIdx.push(type%4==0?j:-1);
                    break;
                }
        updateModel();
    }
}
