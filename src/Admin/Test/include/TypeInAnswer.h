//
// Created by arti1208 on 15.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_TYPEINANSWER_H
#define SOFTWARE_GAME_COMPLEX_TYPEINANSWER_H


#include <QString>
#include <QVector>

class TypeInAnswer : public QObject{
    Q_OBJECT
//    QML_ELEMENT

public:
    TypeInAnswer() = default;
    explicit TypeInAnswer(QObject* parent);

    TypeInAnswer(const TypeInAnswer& answer);

    explicit TypeInAnswer(const QVector<QString>& validAnswers);

private:
    QVector<QString> validAnswers;
};


#endif //SOFTWARE_GAME_COMPLEX_TYPEINANSWER_H
