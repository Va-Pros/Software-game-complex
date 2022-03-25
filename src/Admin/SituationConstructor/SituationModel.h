//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H

#include <QObject>
#include <QString>
#include <QMetaType>
#include <QDebug>

class SituationModel : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName)
    Q_PROPERTY(int someData READ getSomeData WRITE setSomeData)

public:
    SituationModel() : QObject(), name(), someData(0) {
        qDebug() << "newModel1";
    }

    SituationModel(const QString& name, int someData) : QObject(), name(name), someData(someData) {
        qDebug() << "newModel2";
    }

    SituationModel(const SituationModel& model) : SituationModel(model.name, model.someData) {
        qDebug() << "newModel3";
    }

    [[nodiscard]] const QString& getName() const {
        return name;
    }

    [[nodiscard]] int getSomeData() const {
        return someData;
    }

    void setName(const QString& name) {
        qDebug() << "setting name " << name;
        SituationModel::name = name;
    }

    void setSomeData(int someData) {
        qDebug() << "setting data " << someData;
        SituationModel::someData = someData;
    }



private:
    QString name;
    int someData;

};

QDataStream &operator<<(QDataStream & out, const SituationModel & model);

QDataStream &operator>>(QDataStream & in, SituationModel & model);

Q_DECLARE_METATYPE(SituationModel)

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONMODEL_H
