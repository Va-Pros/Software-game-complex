//
// Created by arti1208 on 08.03.2022.
//

#include "SimpleSituationNode.h"

SimpleSituationNode::SimpleSituationNode(
        const QString& subtype,
        const QList<ProtectionTool*>& protectionTools
) : subtype(subtype), protectionTools(protectionTools) {}

QString SimpleSituationNode::getSubtype() {
    return subtype;
}
QList<ProtectionTool*> SimpleSituationNode::getProtectionTools(){
    return protectionTools;
}
