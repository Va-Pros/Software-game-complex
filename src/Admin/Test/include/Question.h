//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTION_H
#define SOFTWARE_GAME_COMPLEX_QUESTION_H

//#define REGISTER_QUESTION_TYPE

#include <QString>
#include <QWidget>

class Question : public QObject{
    Q_OBJECT

protected:
    explicit Question(QObject* parent = nullptr);

    explicit Question(const QString& text);

    QString text;

};


#endif    // SOFTWARE_GAME_COMPLEX_QUESTION_H
