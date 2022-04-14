//
// Created by arti1208 on 14.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONEDGE_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONEDGE_H

#include <QString>
#include <QObject>
#include <QList>
#include "SituationNode.h"
#include "SituationItem.h"

class SituationEdge : public SituationItem {
    Q_OBJECT

public:
    QString getType() override {
        return "edge";
    }

    virtual QString getSubtype() = 0;

    virtual SituationNode* getFirstNode() = 0;

    virtual SituationNode* getSecondNode() = 0;

};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONEDGE_H
