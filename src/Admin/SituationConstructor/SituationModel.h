//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H

#include <QObject>
#include <QString>
#include <QMetaType>
#include <QDebug>
#include "SituationNet.h"

class SituationModel : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName)

public:
    enum class Difficulty {
        SIMPLE,
        MEDIUM,
        HARD
    };


    SituationModel(QObject *parent, int id, const QString & name, Difficulty difficulty, const SituationNet & graph, const QString & resources, const QString & net, const QString & intruder, const QString & rights):QObject(parent),id(id),name(name),difficulty(difficulty),graph(graph),resources(resources),net(net),intruder(intruder),rights(rights){}

    [[nodiscard]] const QString& getName() const {
        return name;
    }

    void setName(const QString& name) {
        qDebug() << "setting name " << name;
        SituationModel::name = name;
    }

    int getId() const{
        return id;
    }

    void setId(int id){
        SituationModel::id = id;
    }

    Difficulty getDifficulty() const{
        return difficulty;
    }

    void setDifficulty(Difficulty difficulty){
        SituationModel::difficulty = difficulty;
    }

    const SituationNet & getGraph() const{
        return graph;
    }

//    void setGraph(const SituationNet & graph){
//        SituationModel::graph = graph;
//    }

    const QString & getResources() const{
        return resources;
    }

    void setResources(const QString & resources){
        SituationModel::resources = resources;
    }

    const QString & getNet() const{
        return net;
    }

    void setNet(const QString & net){
        SituationModel::net = net;
    }

    const QString & getIntruder() const{
        return intruder;
    }

    void setIntruder(const QString & intruder){
        SituationModel::intruder = intruder;
    }

    const QString & getRights() const{
        return rights;
    }

    void setRights(const QString & rights){
        SituationModel::rights = rights;
    }


private:
    int id;
    QString name;
    Difficulty difficulty;
    SituationNet graph;
    QString resources;
    QString net;
    QString intruder;
    QString rights;

};

QDataStream &operator<<(QDataStream & out, const SituationModel & model);

QDataStream &operator>>(QDataStream & in, SituationModel & model);

//Q_DECLARE_METATYPE(SituationModel)

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H
