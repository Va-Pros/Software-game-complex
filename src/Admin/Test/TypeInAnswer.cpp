//
// Created by arti1208 on 15.01.2022.
//

#include <QObject>
#include "include/TypeInAnswer.h"

TypeInAnswer::TypeInAnswer(const QVector<QString>& validAnswers) : validAnswers(validAnswers) {}

TypeInAnswer::TypeInAnswer(QObject* parent) : QObject(parent) {}

TypeInAnswer::TypeInAnswer(const TypeInAnswer& answer) : QObject(), validAnswers(answer.validAnswers) {}