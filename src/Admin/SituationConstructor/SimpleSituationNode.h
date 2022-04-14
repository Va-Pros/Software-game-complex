//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H
#define SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H


#include "SituationNode.h"

class SimpleSituationNode : public SituationNode {

public:
    SimpleSituationNode(const QString& subtype, const QList<ProtectionTool*>& protectionTools);

    QString getSubtype() override;

    QList<ProtectionTool*> getProtectionTools() override;

private:
    QString subtype;
    QList<ProtectionTool*> protectionTools;

};


#endif //SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H
