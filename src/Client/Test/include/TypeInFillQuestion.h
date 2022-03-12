//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_TYPEINFILLQUESTION_H
#define SOFTWARE_GAME_COMPLEX_TYPEINFILLQUESTION_H


#include "FillQuestion.h"
#include "TypeInAnswer.h"

class TypeInFillQuestion final : public FillQuestion {

public:

    TypeInFillQuestion(const QString& text, const QVector<int>& offsets, const QVector<TypeInAnswer>& answers);

private:

    QVector<TypeInAnswer> answers;

};


#endif //SOFTWARE_GAME_COMPLEX_TYPEINFILLQUESTION_H
