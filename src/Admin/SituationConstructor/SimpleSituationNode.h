//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H
#define SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H


#include "SituationNode.h"

class SimpleSituationNode : public SituationNode {

public:
    SimpleSituationNode(const QString& name, const QString& image);

    QString getName() override;

    QString getImage() override;

private:
    QString name;
    QString image;

};


#endif //SOFTWARE_GAME_COMPLEX_SIMPLESITUATIONNODE_H
