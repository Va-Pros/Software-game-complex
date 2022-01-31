//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_CHOICEQUESTION_H
#define SOFTWARE_GAME_COMPLEX_CHOICEQUESTION_H


#include <QString>
#include <QVector>
#include "Question.h"
#include "ChoiceAnswer.h"

class ChoiceQuestion : public Question {

protected:
    ChoiceQuestion(const QString& text, const ChoiceAnswer& answer);

protected:

    ChoiceAnswer answer;

};


#endif    // SOFTWARE_GAME_COMPLEX_CHOICEQUESTION_H
