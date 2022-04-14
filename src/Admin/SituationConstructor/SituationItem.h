//
// Created by arti1208 on 14.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONITEM_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONITEM_H

#include <QString>
#include <QObject>

class SituationItem : public QObject {
    Q_OBJECT

public:
    virtual QString getType() = 0;
};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONITEM_H
