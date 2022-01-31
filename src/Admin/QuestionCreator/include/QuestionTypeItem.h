//
// Created by arti1208 on 29.01.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONTYPEITEM_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONTYPEITEM_H

#include <QString>
#include <QObject>

class QuestionTypeItem : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString title READ getTitle)
    Q_PROPERTY(QString qmlPath READ getQmlPath)

public:
    explicit QuestionTypeItem(QString title, QString qmlPath) : QObject(nullptr), title(std::move(title)), qmlPath(std::move(qmlPath)) {}

    [[nodiscard]] const QString& getTitle() const {
        return title;
    }

    [[nodiscard]] const QString& getQmlPath() const {
        return qmlPath;
    }

private:
    QString title;
    QString qmlPath;
};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONTYPEITEM_H
