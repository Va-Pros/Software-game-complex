#include "Themes.h"

#include "utils/enums.h"

Themes::Themes(QObject *parent) : QObject(parent) {}
Themes::~Themes() = default;

int Themes::getNumberOfEasy(const QString &theme) {
	if (data.contains(theme)) {
		return data.value(theme).numberOfQuestions[static_cast<int>(QuestionDifficulty::EASY)];
	} else {
		return -1;
	}
}
int Themes::getNumberOfMedium(const QString &theme) {
	if (data.contains(theme)) {
		return data.value(theme).numberOfQuestions[static_cast<int>(QuestionDifficulty::MEDIUM)];
	} else {
		return -1;
	}
}
int Themes::getNumberOfHard(const QString &theme) {
	if (data.contains(theme)) {
		return data.value(theme).numberOfQuestions[static_cast<int>(QuestionDifficulty::HARD)];
	} else {
		return -1;
	}
}

bool Themes::addTheme(const QString &theme, const int numberOfQuestions[]) {
	if (data.contains(theme)) {
		return false;
	}
	data.insert(theme, NumberOfQuestion(numberOfQuestions));
	return true;
}

bool Themes::addTheme(const QString &theme, const NumberOfQuestion &numberOfQuestion) {
	if (data.contains(theme)) {
		return false;
	}
	data.insert(theme, numberOfQuestion);
	return true;
}

void Themes::setModelThemes(QStringList &uniqueThemes) {
	themes.setData(uniqueThemes);
	gameSettingsThemes.setData(uniqueThemes);
}

ListModel *Themes::getThemes() { return &themes; }

ListModel *Themes::getGameSettingsThemes() { return &gameSettingsThemes; }
