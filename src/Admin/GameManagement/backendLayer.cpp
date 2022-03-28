#include "backendLayer.h"

#include <qdebug.h>
#include <utility>

CheckableTheme::CheckableTheme()
	: _numberOfEasyQuestions(-1), _numberOfMediumQuestions(-1), _numberOfHardQuestions(-1) {};
CheckableTheme::CheckableTheme(QString title, qint32 easy, qint32 medium, qint32 hard)
	: _title(std::move(title)), _numberOfEasyQuestions(easy), _numberOfMediumQuestions(medium),
	  _numberOfHardQuestions(hard) {};
//CheckableTheme &CheckableTheme::operator=(const CheckableTheme &theme) {
//	this->_title				   = theme._title;
//	this->_numberOfEasyQuestions   = theme._numberOfEasyQuestions;
//	this->_numberOfMediumQuestions = theme._numberOfMediumQuestions;
//	this->_numberOfHardQuestions   = theme._numberOfHardQuestions;
//	return *this;
//}


CheckableTheme::CheckableTheme(const CheckableTheme &theme)
	: CheckableTheme(theme._title, theme._numberOfEasyQuestions, theme._numberOfMediumQuestions,
					 theme._numberOfHardQuestions) {}

void CheckableTheme::setTitle(const QString &title) { _title = title; }
void CheckableTheme::setNumberOfEasyQuestions(qint32 number) { _numberOfEasyQuestions = number; }
void CheckableTheme::setNumberOfMediumQuestions(qint32 number) { _numberOfMediumQuestions = number; }
void CheckableTheme::setNumberOfHardQuestions(qint32 number) { _numberOfHardQuestions = number; }
QString CheckableTheme::getTitle() { return _title; }
qint32 CheckableTheme::getNumberOfEasyQuestions() { return _numberOfEasyQuestions; }
qint32 CheckableTheme::getNumberOfMediumQuestions() { return _numberOfMediumQuestions; }
qint32 CheckableTheme::getNumberOfHardQuestions() { return _numberOfHardQuestions; }

SessionSettings::SessionSettings()
	: title(), checkableThemes(), satisfactoryNumberOfCorrectAnswers(-1), goodNumberOfCorrectAnswers(-1),
	  excellentNumberOfCorrectAnswers(-1), testTime(-1), situationDifficulty(Utils::SituationDifficulty::UNDEFINED),
	  gameTime(-1) {};

void SessionSettings::setSettings(QString title, QString themes, qint32 satisfactory, qint32 good,
								  qint32 excellent, qint32 testTime, qint32 situationDifficulty, qint32 gameTime) {
	this->title = std::move(title);
	//	this->checkableThemes.push_back(themes);
//	this->checkableThemes = themes;
	// themes
	this->satisfactoryNumberOfCorrectAnswers = satisfactory;
	this->goodNumberOfCorrectAnswers		 = good;
	this->excellentNumberOfCorrectAnswers	 = excellent;
	this->testTime							 = testTime;
	this->situationDifficulty				 = situationDifficulty;
	this->gameTime							 = gameTime;
	qDebug() << "title " << this->title;
//	qDebug() << "theme title" << themes._title;
//	qDebug() << "theme easy" << themes._numberOfEasyQuestions;
//	qDebug() << "theme medium" << themes._numberOfMediumQuestions;
//		qDebug() << "theme hard" << themes._numberOfHardQuestions;
	qDebug() << "satisfactory " << this->satisfactoryNumberOfCorrectAnswers;
	qDebug() << "good " << this->goodNumberOfCorrectAnswers;
	qDebug() << "excellent " << this->excellentNumberOfCorrectAnswers;
	qDebug() << "testTime" << this->testTime;
	qDebug() << "difficulty" << this->situationDifficulty;
	qDebug() << "gameTime" << this->gameTime;
}