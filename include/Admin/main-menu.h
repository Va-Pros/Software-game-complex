#ifndef SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H
#define SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H

#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QWidget>

namespace Puzzle {
class MainMenu : public QWidget {
	Q_OBJECT

public:
	MainMenu();

public slots:
	void questionDesignerBtnClick();
	void situationDesignerBtnClick();
	void resultsViewerBtnClick();
	void gameManagementBtnClick();

signals:
	void needSceneChanged(int idx);

private:
	QLabel header;

	QPushButton questionDesignerBtn;
	QPushButton situationDesignerBtn;
	QPushButton resultsViewerBtn;
	QPushButton gameManagementBtn;

	QVBoxLayout mainLayout;
	QVBoxLayout headerLayout;
	QHBoxLayout buttonsLayout;
};

}  // namespace Puzzle

#endif	// SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H
