//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEANSWER_H
#define SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEANSWER_H


#include "ChoiceAnswer.h"

class MultipleChoiceAnswer final : public ChoiceAnswer {

public:
    MultipleChoiceAnswer(const QVector<QString>& variants, const QVector<int>& correctVariantIndices);

private:

    QVector<int> correctVariantIndices;

};


#endif //SOFTWARE_GAME_COMPLEX_MULTIPLECHOICEANSWER_H
