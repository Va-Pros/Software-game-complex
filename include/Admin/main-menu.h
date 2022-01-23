#ifndef SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H
#define SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H

#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QWidget>

namespace Puzzle {
    class MainMenu : public QObject {
        Q_OBJECT

public:

	Q_INVOKABLE void questionDesignerBtnClick();
    Q_INVOKABLE void situationDesignerBtnClick();
    Q_INVOKABLE void resultsViewerBtnClick();
    Q_INVOKABLE void gameManagementBtnClick();

};

}  // namespace Puzzle

#endif	// SOFTWARE_GAME_COMPLEX_ADMIN_MAINMENU_H
