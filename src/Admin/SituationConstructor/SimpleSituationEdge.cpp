//
// Created by arti1208 on 14.04.2022.
//

#include "SimpleSituationEdge.h"

SimpleSituationEdge::SimpleSituationEdge(QString& subtype, SituationNode *firstNode, SituationNode *secondNode) : subtype(subtype), firstNode(firstNode),secondNode(secondNode){}

SituationNode* SimpleSituationEdge::getFirstNode() {
    return firstNode;
}

SituationNode* SimpleSituationEdge::getSecondNode() {
    return secondNode;
}

QString SimpleSituationEdge::getSubtype(){
    return subtype;
}
