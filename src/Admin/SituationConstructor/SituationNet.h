//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONNET_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONNET_H

#include <QList>
#include <QObject>
#include "SituationNode.h"
#include "SituationEdge.h"

class SituationNet : public QObject {
    Q_OBJECT

public:
    SituationNet(QObject *parent, const QList<SituationNode *> & nodes, const QList<SituationEdge*> & edges):QObject(parent), nodes(nodes), edges(edges){}

    SituationNet(const SituationNet& other): SituationNet(nullptr, other.nodes, other.edges) {}

    const QList<SituationNode*>& getNodes() const {
        return nodes;
    }

    void setNodes(const QList<SituationNode*>& nodes) {
        SituationNet::nodes = nodes;
    }

    const QList<SituationEdge *> & getEdges() const {
        return edges;
    }

private:
    QList<SituationNode*> nodes;
    QList<SituationEdge*> edges;

};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONNET_H
