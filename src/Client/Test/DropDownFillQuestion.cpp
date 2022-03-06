//
// Created by arti1208 on 15.01.2022.
//

#include "include/DropDownFillQuestion.h"

DropDownFillQuestion::DropDownFillQuestion(
    const QString& text, const QVector<int>& offsets, const QVector<SingleChoiceAnswer>& answers
) : FillQuestion(text, offsets), answers(answers) {}
