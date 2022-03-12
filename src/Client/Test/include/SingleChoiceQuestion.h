//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SINGLECHOICEQUESTION_H
#define SOFTWARE_GAME_COMPLEX_SINGLECHOICEQUESTION_H

#include <QString>
#include <QVector>
#include "SingleChoiceAnswer.h"
#include "ChoiceQuestion.h"

class SingleChoiceQuestion final : public ChoiceQuestion {

public:

    SingleChoiceQuestion(const QString& text, const SingleChoiceAnswer& answer);

};


#endif    // SOFTWARE_GAME_COMPLEX_SINGLECHOICEQUESTION_H
