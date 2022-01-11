
#ifndef SOFTWARE_GAME_COMPLEX_ADMIN_ADMIN_H
#define SOFTWARE_GAME_COMPLEX_ADMIN_ADMIN_H

#include "Admin/main-menu.h"
#include "Admin/question-designer.h"

#include <QMainWindow>
#include <QStackedWidget>

namespace Puzzle {
class Admin : public QMainWindow {
	Q_OBJECT

public:
	Admin();

public slots:
	void changeScene(int idx);

private:
	QStackedWidget sceneContainer;
	// Разные сцены -- классы, унаследованные от QWidget
	MainMenu mainMenuScene;
	QuestionDesigner questionDesignerScene;
};
}  // namespace Puzzle

#endif
