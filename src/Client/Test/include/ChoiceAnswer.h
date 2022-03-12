//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_CHOICEANSWER_H
#define SOFTWARE_GAME_COMPLEX_CHOICEANSWER_H


#include <QString>
#include <QVector>

class ChoiceAnswer {

public:
    ChoiceAnswer(const QVector<QString>& variants);

private:
    QVector<QString> variants;

};


#endif //SOFTWARE_GAME_COMPLEX_CHOICEANSWER_H
