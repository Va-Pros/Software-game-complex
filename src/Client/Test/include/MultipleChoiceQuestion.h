//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEQUESTION_H
#define SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEQUESTION_H


#include "ChoiceQuestion.h"
#include "MultipleChoiceAnswer.h"

class MultipleChoiceQuestion final : public ChoiceQuestion {

public:
    MultipleChoiceQuestion(
        const QString& text, const MultipleChoiceAnswer& answer
    );


};


#endif    // SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEQUESTION_H
