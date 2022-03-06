//
// Created by arti1208 on 05.02.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEITEM_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEITEM_H

#include <QString>
#include <QObject>

class QuestionThemeItem : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString title READ getTitle)

public:
    explicit QuestionThemeItem(QString title) : QObject(nullptr), title(std::move(title)) {}

    [[nodiscard]] const QString& getTitle() const {
        return title;
    }

private:
    QString title;

};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONTHEMEITEM_H
