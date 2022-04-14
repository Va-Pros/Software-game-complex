//
// Created by arti1208 on 14.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SIMPLEPROTECTIONTOOL_H
#define SOFTWARE_GAME_COMPLEX_SIMPLEPROTECTIONTOOL_H

#include "ProtectionTool.h"

class SimpleProtectionTool : public ProtectionTool {

public:
    SimpleProtectionTool(const QString & type);

    QString getSubtype() override;

private:
    QString type;

};



#endif //SOFTWARE_GAME_COMPLEX_SIMPLEPROTECTIONTOOL_H
