#ifndef SOFTWARE_GAME_COMPLEX_NUMBEROFQUESTION_H
#define SOFTWARE_GAME_COMPLEX_NUMBEROFQUESTION_H

#include "Themes.h"
#include "utils/enums.h"

class NumberOfQuestion {
	friend class Themes;

public:
	NumberOfQuestion() {
		for (int &numberOfQuestion : numberOfQuestions) {
			numberOfQuestion = -1;
		}
	}
	NumberOfQuestion(const int numberOfQuestions[]) {
		for (int i = 0; i < NUMBER_OF_LEVEL_QUESTION_DIFFICULTY; ++i) {
			this->numberOfQuestions[i] = numberOfQuestions[i];
		}
	}

private:
	int numberOfQuestions[NUMBER_OF_LEVEL_QUESTION_DIFFICULTY];
};

#endif	// SOFTWARE_GAME_COMPLEX_NUMBEROFQUESTION_H
