//
// Created by arti1208 on 29.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONTYPELISTMODEL_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONTYPELISTMODEL_H

#include <QAbstractListModel>
#include "QuestionTypeItem.h"

class QuestionTypeListModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum QuestionTypeRoles {
        TitleRole = Qt::UserRole + 1,
        UiPathRole,
    };

    QuestionTypeListModel(QObject* parent, const QList<QuestionTypeItem*>& data) : QAbstractListModel(parent),
                                                                                   types(data) {}

    [[nodiscard]] QVariant data(const QModelIndex& index, int role) const override {

        switch (role) {
            case TitleRole:
                return QVariant(types[index.row()]->getTitle());
            case UiPathRole:
                return QVariant(types[index.row()]->getQmlPath());
        }

        return QVariant();
    }

    [[nodiscard]] int rowCount(const QModelIndex& parent) const override {
        Q_UNUSED(parent);
        return types.count();
    }

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[TitleRole] = "title";
        roles[UiPathRole] = "ui";
        return roles;
    }

private:
    QList<QuestionTypeItem*> types;


};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONTYPELISTMODEL_H
