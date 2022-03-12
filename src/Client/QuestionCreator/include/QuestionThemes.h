//
// Created by arti1208 on 05.02.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONTHEMES_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONTHEMES_H

#include <QObject>
#include <QTimer>
#include "QuestionThemeModel.h"

class QuestionThemes : public QObject {
    Q_OBJECT
    Q_PROPERTY(QuestionThemeModel* model READ getThemeModel NOTIFY modelChanged)

public:
    QuestionThemes() : QObject(nullptr) {

        // TODO get themes from db or something
        QList<QuestionThemeItem*> themes;
        themes += new QuestionThemeItem(tr("Example1"));
        themes += new QuestionThemeItem(tr("Example2"));
        themes += new QuestionThemeItem(tr("Example3"));
        themeModel = new QuestionThemeModel(nullptr, themes);

        // emulate loading from DB
        QTimer::singleShot(3000, this, [this] { emit modelChanged(); });
    }

    Q_INVOKABLE QuestionThemeModel* getThemeModel() {
        return themeModel;
    }

signals:
    void modelChanged();

private:
    QuestionThemeModel* themeModel;

};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONTHEMES_H
