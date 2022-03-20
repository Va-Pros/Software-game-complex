//
// Created by arti1208 on 08.03.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_SITUATIONMODIFYHELPER_H
#define SOFTWARE_GAME_COMPLEX_SITUATIONMODIFYHELPER_H

#include <QObject>
#include <iostream>
#include <QQmlEngine>
#include <QFile>
#include <QDataStream>
#include "SituationModel.h"

class SituationModifyHelper: public QObject {
    Q_OBJECT


public:
    Q_INVOKABLE void saveSituationModel(
        const QVariant& variant,
        const QString& path
    ) {

        auto model = variant.value<SituationModel*>();

        QFile file(QUrl(path).toLocalFile());
        if (file.open(QIODevice::ReadWrite)) {


            QDataStream out(&file);
            out << *model;

            file.flush();
            file.close();

            emit saved(path);
        } else {
            emit saveFailed("File opening failed");
        }
    }

    Q_INVOKABLE void importSituationModel(
        const QString& path
    ) {

        SituationModel model;

        QFile file(QUrl(path).toLocalFile());
        if (file.open(QIODevice::ReadOnly | QIODevice::ExistingOnly)) {

            QDataStream in(&file);
            in >> model;

            file.flush();
            file.close();

            QVariant variant;
            variant.setValue(&model);

            emit imported(variant, path);
        } else {
            emit importFailed("File opening failed", path);
        }
    }

    static SituationModifyHelper* singletonProvider(QQmlEngine* engine, QJSEngine* scriptEngine)
    {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        return new SituationModifyHelper();
    }

signals:
    void saved(QString path);

    void saveFailed(QString error);

    void imported(QVariant model, QString path);

    void importFailed(QString error, QString path);
};

#endif //SOFTWARE_GAME_COMPLEX_SITUATIONMODIFYHELPER_H
