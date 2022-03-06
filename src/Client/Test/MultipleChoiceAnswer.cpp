//
// Created by arti1208 on 15.01.2022.
//

#include "include/MultipleChoiceAnswer.h"

MultipleChoiceAnswer::MultipleChoiceAnswer(const QVector<QString>& variants, const QVector<int>& correctVariantIndices)
    : ChoiceAnswer(variants), correctVariantIndices(correctVariantIndices) {}
