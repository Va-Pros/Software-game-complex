#ifndef SOFTWARE_GAME_COMPLEX_MAIN_H
#define SOFTWARE_GAME_COMPLEX_MAIN_H
#include <QLabel>
#include <QMainWindow>
#include <QPushButton>
#include <QStackedWidget>
#include <QVBoxLayout>
class Example : public QMainWindow {
	Q_OBJECT

public:
	Example();

public slots:
	void firstPageButtonClick();
	void secondPageButtonClick();

private:
	QStackedWidget stackedWidget;
	QWidget firstPage;
	QWidget secondPage;

	QVBoxLayout firstPageMainLayout;
	QVBoxLayout secondPageMainLayout;

	QPushButton firstPageButton;
	QLabel firstPageLabel;
	QPixmap firstPagePixmap;

	QPushButton secondPageButton;
	QLabel secondPageLabel;
	QPixmap secondPagePixmap;

};
#endif
