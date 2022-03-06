//
// Created by arti1208 on 05.02.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEMODEL_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEMODEL_H

#include <QAbstractListModel>
#include "QuestionThemeItem.h"

class QuestionThemeModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum QuestionTypeRoles {
        TitleRole = Qt::UserRole + 1,
    };

    QuestionThemeModel(QObject* parent, const QList<QuestionThemeItem*>& data) : QAbstractListModel(parent),
                                                                                       themes(data) {
    }

    [[nodiscard]] QVariant data(const QModelIndex& index, int role) const override {

        switch (role) {
            case TitleRole:
                return QVariant(themes[index.row()]->getTitle());
        }

        return QVariant();
    }

    [[nodiscard]] int rowCount(const QModelIndex& parent) const override {
        Q_UNUSED(parent);
        return themes.count();
    }

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[TitleRole] = "title";
        return roles;
    }

    Q_INVOKABLE QuestionThemeItem* getTheme(int index) {
        return themes[index];
//        return std::transform(themes.begin(), themes.end(), [](QuestionThemeItem* el) -> QuestionThemeItem { return *el; });
    }

    Q_INVOKABLE int count() {
        return themes.size();
    }

private:
    QList<QuestionThemeItem*> themes;


};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEMODEL_H
