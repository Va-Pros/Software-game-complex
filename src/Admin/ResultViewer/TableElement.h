

#ifndef SOFTWARE_GAME_COMPLEX_TABLEELEMENT_H
#define SOFTWARE_GAME_COMPLEX_TABLEELEMENT_H


#include "utils/enums.h"

#include <QString>
class TableElement {
public:
	TableElement();
	TableElement(QString &name, qint32 platoon);
	TableElement(QString &name, qint32 platoon, Role role, qint32 testScore, qint32 gameScore, qint32 totalScore);

private:
	QString name;
	qint32 platoon;
	Role role;
	qint32 testScore;
	qint32 gameScore;
	qint32 totalScore;
};


#endif	// SOFTWARE_GAME_COMPLEX_TABLEELEMENT_H
