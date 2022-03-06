//
// Created by arti1208 on 15.01.2022.
//

#include "include/FillQuestion.h"

FillQuestion::FillQuestion(const QString& text, const QVector<int>& offsets) : Question(text), offsets(offsets) {}
