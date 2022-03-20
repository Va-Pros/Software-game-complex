//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H


#include <QString>
#include <QObject>

class SituationNode : public QObject {
    Q_OBJECT

public:
    virtual QString getName() = 0;

    virtual QString getImage() = 0;

};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H
