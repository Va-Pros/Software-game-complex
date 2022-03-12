//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_FILLQUESTION_H
#define SOFTWARE_GAME_COMPLEX_FILLQUESTION_H


#include <QVector>
#include "Question.h"

class FillQuestion : public Question {

protected:
    FillQuestion(const QString& text, const QVector<int>& offsets);

private:
    QVector<int> offsets;

};


#endif //SOFTWARE_GAME_COMPLEX_FILLQUESTION_H
