//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_DROPDOWNFILLQUESTION_H
#define SOFTWARE_GAME_COMPLEX_DROPDOWNFILLQUESTION_H


#include "FillQuestion.h"
#include "SingleChoiceAnswer.h"

class DropDownFillQuestion final : public FillQuestion {

public:
    DropDownFillQuestion(const QString& text, const QVector<int>& offsets, const QVector<SingleChoiceAnswer>& answers);

private:

    QVector<SingleChoiceAnswer> answers;

};


#endif //SOFTWARE_GAME_COMPLEX_DROPDOWNFILLQUESTION_H
