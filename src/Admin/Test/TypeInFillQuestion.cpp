//
// Created by arti1208 on 15.01.2022.
//

#include "include/TypeInFillQuestion.h"

TypeInFillQuestion::TypeInFillQuestion(
    const QString& text,
    const QVector<int>& offsets,
    const QVector<TypeInAnswer>& answers
) : FillQuestion(text, offsets), answers(answers) {}
