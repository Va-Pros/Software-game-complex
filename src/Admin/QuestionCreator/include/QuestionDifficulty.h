//
// Created by arti1208 on 05.02.2022.
//

#ifndef SOFTWARE_GAME_COMPLEX_QUESTIONDIFFICULTY_H
#define SOFTWARE_GAME_COMPLEX_QUESTIONDIFFICULTY_H

class QuestionDifficulty : public QObject {
    Q_OBJECT
public:
    enum DifficultyType {
        EASY,
        MEDIUM,
        HARD,
    };

    Q_ENUM(DifficultyType)

    QuestionDifficulty() : QObject() {}

    void setDifficulty(DifficultyType difficulty) {
        m_difficulty = difficulty;
    }

    [[nodiscard]] DifficultyType difficulty() const {
        return m_difficulty;
    }

private:
    DifficultyType m_difficulty;
};

#endif //SOFTWARE_GAME_COMPLEX_QUESTIONDIFFICULTY_H
