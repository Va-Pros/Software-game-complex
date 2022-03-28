
#ifndef SOFTWARE_GAME_COMPLEX_ENUMS_H
#define SOFTWARE_GAME_COMPLEX_ENUMS_H
#include <QObject>


class Utils : public QObject {
	Q_OBJECT

public:
	Utils() : QObject() {}
	enum SituationDifficulty { UNDEFINED, EASY, MEDIUM, HARD };
	Q_ENUM(SituationDifficulty);
};
#endif	// SOFTWARE_GAME_COMPLEX_ENUMS_H
