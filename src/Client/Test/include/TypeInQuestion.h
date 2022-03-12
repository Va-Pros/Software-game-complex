//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_TYPEINQUESTION_H
#define SOFTWARE_GAME_COMPLEX_TYPEINQUESTION_H


#include "Question.h"
#include "TypeInAnswer.h"

class TypeInQuestion : public Question {
    Q_OBJECT

public:

    explicit TypeInQuestion(QObject* parent = nullptr);

    TypeInQuestion(const QString& text, const TypeInAnswer& answer);

private:

    TypeInAnswer answer;

};


#endif //SOFTWARE_GAME_COMPLEX_TYPEINQUESTION_H
