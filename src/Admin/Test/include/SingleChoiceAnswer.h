//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SINGLECHOICEANSWER_H
#define SOFTWARE_GAME_COMPLEX_SINGLECHOICEANSWER_H


#include "ChoiceAnswer.h"

class SingleChoiceAnswer final : public ChoiceAnswer {

public:

    SingleChoiceAnswer(const QVector<QString>& variants, int correctVariantIndex);

private:
    int correctVariantIndex;
};


#endif //SOFTWARE_GAME_COMPLEX_SINGLECHOICEANSWER_H
