//
// Created by arti1208 on 14.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONEDGE_H
#define SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONEDGE_H

#include "SituationEdge.h"

class SimpleSituationEdge : public SituationEdge {
public:

    SimpleSituationEdge(QString& subtype, SituationNode *firstNode, SituationNode *secondNode);

    QString getSubtype() override;
    SituationNode* getFirstNode() override;
    SituationNode* getSecondNode() override;

private:
    QString subtype;
    SituationNode* firstNode;
    SituationNode* secondNode;

};



#endif //SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONEDGE_H
