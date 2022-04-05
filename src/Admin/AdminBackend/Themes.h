
#ifndef SOFTWARE_GAME_COMPLEX_THEMES_H
#define SOFTWARE_GAME_COMPLEX_THEMES_H

#include "NumberOfQuestion.h"
#include "ListModel.h"

#include <QHash>
#include <QObject>


class Themes : public QObject {
	Q_OBJECT
	Q_PROPERTY(ListModel *gameSettingsThemesModel READ getGameSettingsThemes CONSTANT)
	Q_PROPERTY(ListModel *themesModel READ getThemes CONSTANT)

public:
	explicit Themes(QObject *parent = nullptr);
	~Themes() override;

	bool addTheme(const QString &theme, const NumberOfQuestion &numberOfQuestion);
	bool addTheme(const QString &theme, const int numberOfQuestions[]);

	ListModel *getGameSettingsThemes();
	ListModel *getThemes();
	void setModelThemes(QStringList &uniqueThemes);
	Q_INVOKABLE int getNumberOfEasy(const QString &theme);
	Q_INVOKABLE int getNumberOfMedium(const QString &theme);
	Q_INVOKABLE int getNumberOfHard(const QString &theme);


private:
	QHash<QString, NumberOfQuestion> data;
	ListModel gameSettingsThemes{};
	ListModel themes{};
};

#endif	// SOFTWARE_GAME_COMPLEX_THEMES_H
