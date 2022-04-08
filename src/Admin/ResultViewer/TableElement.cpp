
#include "TableElement.h"

TableElement::TableElement()
	: name(QString()), platoon(-1), role(Role::UNDEFINED), testScore(-1), gameScore(-1), totalScore(-1) {}

TableElement::TableElement(QString &name, qint32 platoon)
	: name(name), platoon(platoon), role(Role::UNDEFINED), testScore(-1), gameScore(-1), totalScore(-1) {}

TableElement::TableElement(QString &name, qint32 platoon, Role role, qint32 testScore, qint32 gameScore,
						   qint32 totalScore)
	: name(name), platoon(platoon), role(role), testScore(testScore), gameScore(gameScore), totalScore(totalScore) {};