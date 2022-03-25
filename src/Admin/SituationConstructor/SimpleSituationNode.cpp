//
// Created by arti1208 on 08.03.2022.
//

#include "SimpleSituationNode.h"

SimpleSituationNode::SimpleSituationNode(const QString& name, const QString& image) : name(name), image(image) {}

QString SimpleSituationNode::getName() {
    return name;
}

QString SimpleSituationNode::getImage() {
    return image;
}
