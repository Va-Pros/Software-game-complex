//
// Created by arti1208 on 14.04.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONUTILS_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONUTILS_H

#include <QSqlQuery>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonObject>

#include "SituationModel.h"
#include "SimpleSituationNode.h"
#include "SimpleSituationEdge.h"
#include "SimpleProtectionTool.h"

SituationNode* nodeFromJson(QJsonObject object);

SituationEdge* edgeFromJson(QJsonObject object, const QList<SituationNode*>& nodes);

SituationModel situationFromQuery(QSqlQuery& query);

QJsonDocument situationToJson(SituationModel& model);

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONUTILS_H
