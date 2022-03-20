//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONNET_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONNET_H

#include <QList>
#include <QObject>
#include "SituationNode.h"

class SituationNet : public QObject {
    Q_OBJECT

public:
    const QList<SituationNode*>& getNodes() const {
        return nodes;
    }

    void setNodes(const QList<SituationNode*>& nodes) {
        SituationNet::nodes = nodes;
    }

private:
    QList<SituationNode*> nodes;

};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONNET_H
