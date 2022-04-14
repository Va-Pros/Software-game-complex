//
// Created by arti1208 on 08.03.2022.
//

#include <QDataStream>
#include "SituationModel.h"

QDataStream &operator<<(QDataStream & out, const SituationModel & model) {

    out << model.getName();
    //out << model.getSomeData();

    return out;
}

QDataStream &operator>>(QDataStream & in, SituationModel & model) {

    QString string;
    int integer;

    in >> string;
    model.setName(string);

//    in >> integer;
//    model.setSomeData(integer);

    return in;
}
