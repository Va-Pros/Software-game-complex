//
// Created by arti1208 on 11.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_PROTECTIONTOOL_H
#define SOFTWARE_GAME_COMPLEX_PROTECTIONTOOL_H

#include <QString>
#include <QObject>
#include "SituationItem.h"

class ProtectionTool : public SituationItem {
    Q_OBJECT

public:
    QString getType() override {
        return "protection";
    }

   virtual QString getSubtype() = 0;

};

#endif //SOFTWARE_GAME_COMPLEX_PROTECTIONTOOL_H
