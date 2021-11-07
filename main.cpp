#include "main.h"

#include <QLabel>
#include <QScreen>
#include <QtWidgets>

Example::Example() {
	QRect screen = QGuiApplication::primaryScreen()->availableGeometry();
	this->resize(screen.width(), screen.height());

	this->setCentralWidget(&this->stackedWidget);

	// stackedWidget content
	stackedWidget.addWidget(&firstPage);
	stackedWidget.addWidget(&secondPage);
	// end stackedWidgetContent

	// firstPage content
	this->firstPageMainLayout.setAlignment(Qt::AlignCenter);
	this->firstPage.setLayout(&this->firstPageMainLayout);
	// end firstPage content

	// firstPageMainLayout content
	this->firstPagePixmap.load(":/images/frog.jpg");
	this->firstPageLabel.setPixmap(this->firstPagePixmap);
	this->firstPageButton.setText("Далее");
	this->firstPageButton.setMinimumSize(QSize(200, 40));
	this->firstPageButton.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	QObject::connect(&firstPageButton, SIGNAL(clicked()), SLOT(firstPageButtonClick()));
	this->firstPageMainLayout.addWidget(&firstPageLabel);
	this->firstPageMainLayout.addWidget(&firstPageButton);
	// end firstPageMainLayout content

	// secondPage content
	this->secondPageMainLayout.setAlignment(Qt::AlignCenter);
	this->secondPage.setLayout(&this->secondPageMainLayout);
	// end secondPage content

	// secondPageMainLayout content
	this->secondPagePixmap.load(":/images/llvm.png");
	this->secondPageLabel.setPixmap(this->secondPagePixmap);
	this->secondPageButton.setText("Назад");
	this->secondPageButton.setMinimumSize(QSize(200, 40));
	this->secondPageButton.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	QObject::connect(&secondPageButton, SIGNAL(clicked()), SLOT(secondPageButtonClick()));
	this->secondPageMainLayout.addWidget(&secondPageButton);
	this->secondPageMainLayout.addWidget(&secondPageLabel);
	// end secondPageMainLayout content
}

void Example::firstPageButtonClick() { this->stackedWidget.setCurrentIndex(1); }

void Example::secondPageButtonClick() { this->stackedWidget.setCurrentIndex(0); }

int main(int argc, char **argv) {
	QApplication app(argc, argv);
	Example example;
	example.show();
	return app.exec();
}