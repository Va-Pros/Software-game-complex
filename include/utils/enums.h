
#ifndef SOFTWARE_GAME_COMPLEX_ENUMS_H
#define SOFTWARE_GAME_COMPLEX_ENUMS_H
#include <QObject>


enum class SituationDifficulty { UNDEFINED, EASY, MEDIUM, HARD };
enum class QuestionDifficulty { EASY, MEDIUM, HARD };

constexpr int NUMBER_OF_LEVEL_QUESTION_DIFFICULTY = static_cast<int>(QuestionDifficulty::HARD) + 1;

#endif	// SOFTWARE_GAME_COMPLEX_ENUMS_H
