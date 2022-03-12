//
// Created by arti1208 on 29.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONCREATORMODEL_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONCREATORMODEL_H

#include <QObject>
#include <QDebug>
#include <memory>
#include "QuestionTypeListModel.h"

class QuestionCreatorModel : public QObject {
    Q_OBJECT


public:
    QuestionCreatorModel() : QObject(nullptr) {
        // TODO collect types automatically
        QList<QuestionTypeItem*> types;
        types += new QuestionTypeItem(tr("Type in"), "qrc:/ui/QuestionEditorWidgets/TypeInQuestionEditor.qml");
        types += new QuestionTypeItem(tr("Single choice"), "qrc:/ui/QuestionEditorWidgets/SingleChoiceQuestionEditor.qml");
        types += new QuestionTypeItem(tr("Multiple choice"), "qrc:/ui/QuestionEditorWidgets/MultipleChoiceQuestionEditor.qml");
        types += new QuestionTypeItem(tr("Match"), "qrc:/ui/QuestionEditorWidgets/MatchQuestionEditor.qml");
        types += new QuestionTypeItem(tr("Dropdown fill"), "qrc:/ui/QuestionEditorWidgets/DropDownFillQuestionEditor.qml");
        types += new QuestionTypeItem(tr("Type in fill"), "qrc:/ui/QuestionEditorWidgets/TypeInFillQuestionEditor.qml");
        typeListModel = new QuestionTypeListModel(nullptr, types);
    }

    Q_INVOKABLE QuestionTypeListModel* getTypeListModel() {
        return typeListModel;
    }

private:
    QuestionTypeListModel* typeListModel;

};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONCREATORMODEL_H
