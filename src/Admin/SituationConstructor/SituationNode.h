//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H


#include <QString>
#include <QObject>
#include <QList>
#include "ProtectionTool.h"
#include "SituationItem.h"

class SituationNode : public SituationItem {
    Q_OBJECT

public:
    QString getType() override {
        return "node";
    }

    virtual QString getSubtype() = 0;

    virtual QList<ProtectionTool*> getProtectionTools() = 0;

};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONNODE_H
