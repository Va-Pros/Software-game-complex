//
// Created by arti1208 on 14.04.2022.
//

#include "SituationUtils.h"

SituationNode* nodeFromJson(QJsonObject object) {
    QString subtype = object["subtype"].toString();

    QList<ProtectionTool*> protectionTools;

    for (auto tool : object["protection"].toArray()) {
        QJsonObject toolObject = tool.toObject();
        QString protectionType = toolObject["subtype"].toString();
        protectionTools.push_back(new SimpleProtectionTool(protectionType));
    }

    return new SimpleSituationNode(subtype, protectionTools);
}

SituationEdge* edgeFromJson(QJsonObject object, const QList<SituationNode*>& nodes) {
    QString subtype = object["subtype"].toString();

    int firstId = object["firstId"].toInt();
    int secondId = object["secondId"].toInt();

    SituationNode* firstNode = nodes[firstId];
    SituationNode* secondNode = nodes[secondId];

    return new SimpleSituationEdge(subtype, firstNode, secondNode);
}

SituationModel situationFromQuery(QSqlQuery& query) {
    int id = query.value("id").toInt();
    QString name = query.value("name").toString();
    QString resources = query.value("resources").toString();
    QString net = query.value("net").toString();
    QString intruder = query.value("intruder").toString();
    QString rights = query.value("rights").toString();
    SituationModel::Difficulty difficulty = static_cast<SituationModel::Difficulty>(query.value("difficulty").toInt());


    QString graphData = query.value("data").toString();
    //qDebug() << "Graph data: " << graphData;
    QJsonDocument jsonData = QJsonDocument::fromJson(graphData.toUtf8());

    QList<SituationNode*> nodes = QList<SituationNode*>();
    QList<SituationEdge*> edges = QList<SituationEdge*>();

    for (auto element : jsonData.array()) {
        QJsonObject obj = element.toObject();
        QString type = obj["type"].toString();

        if (type == "node") {
            nodes.push_back(nodeFromJson(obj));
        } else if (type == "edge") {
            edges.push_back(edgeFromJson(obj, nodes));
        }
    }

    SituationNet situationNet = SituationNet(nullptr, nodes, edges);

    return SituationModel(nullptr, id, name, difficulty, situationNet, resources, net, intruder, rights);
}

QJsonDocument situationToJson(SituationModel& model) {
    QJsonObject situationObject;

    situationObject["id"] = model.getId();
    situationObject["resources"] = model.getResources();
    situationObject["net"] = model.getNet();
    situationObject["intruder"] = model.getIntruder();
    situationObject["rights"] = model.getRights();

    const SituationNet& graph = model.getGraph();

    QJsonArray data;

    const QList<SituationNode*>& nodes = graph.getNodes();
    for (auto* node : nodes) {
        QJsonObject nodeObj;
        nodeObj["type"] = node->getType();
        nodeObj["subtype"] = node->getSubtype();

        if (!node->getProtectionTools().isEmpty()) {
            QJsonArray protection;

            for (auto* tool : node->getProtectionTools()) {
                QJsonObject toolObj;
                toolObj["type"] = tool->getType();
                toolObj["subtype"] = tool->getSubtype();

                protection.append(toolObj);
            }

            nodeObj["protection"] = protection;
        }

        data.append(nodeObj);
    }

    for (auto* edge : graph.getEdges()) {
        QJsonObject edgeObj;
        edgeObj["type"] = edge->getType();
        edgeObj["subtype"] = edge->getSubtype();

        edgeObj["firstId"] = nodes.indexOf(edge->getFirstNode());
        edgeObj["secondId"] = nodes.indexOf(edge->getSecondNode());

        data.append(edgeObj);
    }

    situationObject["data"] = data;

    return QJsonDocument(situationObject);
}