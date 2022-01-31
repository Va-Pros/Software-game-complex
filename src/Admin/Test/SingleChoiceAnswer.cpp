//
// Created by arti1208 on 15.01.2022.
//

#include "include/SingleChoiceAnswer.h"

SingleChoiceAnswer::SingleChoiceAnswer(const QVector<QString>& variants, int correctVariantIndex) : ChoiceAnswer(
    variants), correctVariantIndex(correctVariantIndex) {}
