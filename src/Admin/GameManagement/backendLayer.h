
#ifndef SOFTWARE_GAME_COMPLEX_BACKENDLAYER_H
#define SOFTWARE_GAME_COMPLEX_BACKENDLAYER_H
#include "utils/enums.h"

#include <QObject>

class CheckableTheme : public QObject {
	Q_OBJECT
	Q_PROPERTY(QString title READ getTitle WRITE setTitle)
	Q_PROPERTY(qint32 numberOfEasyQuestions READ getNumberOfEasyQuestions WRITE setNumberOfEasyQuestions)
	Q_PROPERTY(qint32 numberOfGoodQuestions READ getNumberOfMediumQuestions WRITE setNumberOfMediumQuestions)
	Q_PROPERTY(qint32 numberOfHardQuestions READ getNumberOfHardQuestions WRITE setNumberOfHardQuestions)
public:
	explicit CheckableTheme();
	explicit CheckableTheme(const CheckableTheme &theme);
	explicit CheckableTheme(QString title, qint32 easy, qint32 medium, qint32 hard);
//	CheckableTheme& operator=(const CheckableTheme& theme);
	void setTitle(const QString &title);
	QString getTitle();
	qint32 getNumberOfEasyQuestions();
	qint32 getNumberOfMediumQuestions();
	qint32 getNumberOfHardQuestions();
	void setNumberOfEasyQuestions(qint32 number);
	void setNumberOfMediumQuestions(qint32 number);
	void setNumberOfHardQuestions(qint32 number);

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
	Q_INVOKABLE void setSettings(QString title, QString themes, qint32 satisfactory, qint32 good, qint32 excellent,
								 qint32 testTime, qint32 situationDifficulty, qint32 gameTime);

private:
	QString title;

	/* Test Settings */
//	QVector<CheckableTheme> checkableThemes;
	CheckableTheme checkableThemes;

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
