
#ifndef SOFTWARE_GAME_COMPLEX_BACKENDLAYER_H
#define SOFTWARE_GAME_COMPLEX_BACKENDLAYER_H
#include "utils/enums.h"

#include <QObject>

class CheckableTheme : public QObject {
	Q_OBJECT

public:
	explicit CheckableTheme();
	explicit CheckableTheme(const CheckableTheme &theme);
	explicit CheckableTheme(QString title, qint32 easy, qint32 medium, qint32 hard);

public:
	QString _title;
	qint32 _numberOfEasyQuestions;
	qint32 _numberOfMediumQuestions;
	qint32 _numberOfHardQuestions;
};

class SessionSettings : public QObject {
	Q_OBJECT

public:
	explicit SessionSettings();
	Q_INVOKABLE void setSettings(QString title, qint32 satisfactory, qint32 good, qint32 excellent, qint32 testTime,
								 qint32 situationDifficulty, qint32 gameTime);
	Q_INVOKABLE void addTheme(QString themeTitle, qint32 easy, qint32 medium, qint32 hard);
	Q_INVOKABLE void printThemes();

private:
	QString title;

	/* Test Settings */
	QVector<CheckableTheme> checkableThemes;
	// In percents
	qint32 satisfactoryNumberOfCorrectAnswers;
	qint32 goodNumberOfCorrectAnswers;
	qint32 excellentNumberOfCorrectAnswers;

	// In minutes
	qint32 testTime;

	/* Game settings */
	qint32 situationDifficulty;
	// In minutes;
	qint32 gameTime;
};
#endif	// SOFTWARE_GAME_COMPLEX_BACKENDLAYER_H
