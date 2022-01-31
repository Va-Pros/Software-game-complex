//
// Created by arti1208 on 15.01.2022.
//

#include <QLabel>
#include <QPushButton>
#include <QBoxLayout>
#include <QLineEdit>
#include <QTextEdit>
#include "include/TypeInQuestion.h"

TypeInQuestion::TypeInQuestion(const QString& text, const TypeInAnswer& answer) : Question(text), answer(answer) {}

TypeInQuestion::TypeInQuestion(QObject* parent) : Question(parent) {

}

