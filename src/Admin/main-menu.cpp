#include "Admin/main-menu.h"
#include "Admin/admin.h"

#include <iostream>

Puzzle::MainMenu::MainMenu() {
	/******* Содержание *******/

	/*** main-menu ***/
	this->setLayout(&mainLayout);

	/*** mainLayout ***/
	mainLayout.addLayout(&headerLayout);
	mainLayout.addLayout(&buttonsLayout);

	/*** headerLayout ***/
	headerLayout.addWidget(&header);

	/*** buttonsLayout ***/
	buttonsLayout.addWidget(&questionDesignerBtn);
	buttonsLayout.addWidget(&situationDesignerBtn);
	buttonsLayout.addWidget(&resultsViewerBtn);
	buttonsLayout.addWidget(&gameManagementBtn);

	/******* Настройка *******/

	/*** main-menu ***/

		/*** headerLayout ***/
		headerLayout.setAlignment(Qt::AlignHCenter | Qt::AlignTop);

	/*** header ***/
	header.setTextInteractionFlags(Qt::TextSelectableByMouse);
	header.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	// TODO Красивое оформление
	header.setStyleSheet("QLabel { color : blue; }");
	header.setText("Программно-игровой комплекс \"Name\"");

	/*** buttonsLayout ***/
	buttonsLayout.setAlignment(Qt::AlignHCenter | Qt::AlignTop);

	/*** questionDesignerBtn ***/
	questionDesignerBtn.setMinimumSize(QSize(200, 40));
	questionDesignerBtn.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	// TODO Красивое оформление
	questionDesignerBtn.setStyleSheet("QPushButton { color : blue; }");
	questionDesignerBtn.setText("Конструктор вопросов");
	QObject::connect(&questionDesignerBtn, SIGNAL(clicked()), SLOT(questionDesignerBtnClick()));

	/*** situationDesignerBtn ***/
	situationDesignerBtn.setMinimumSize(QSize(200, 40));
	situationDesignerBtn.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	// TODO Красивое оформление
	situationDesignerBtn.setStyleSheet("QPushButton { color : blue; }");
	situationDesignerBtn.setText("Конструктор обстановок");
	QObject::connect(&situationDesignerBtn, SIGNAL(clicked()), SLOT(situationDesignerBtnClick()));

	/*** resultsViewerBtn ***/
	resultsViewerBtn.setMinimumSize(QSize(200, 40));
	resultsViewerBtn.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	// TODO Красивое оформление
	resultsViewerBtn.setStyleSheet("QPushButton { color : blue; }");
	resultsViewerBtn.setText("Просмотр результатов");
	QObject::connect(&resultsViewerBtn, SIGNAL(clicked()), SLOT(resultsViewerBtnClick()));

	/*** gameManagementBtn ***/
	gameManagementBtn.setMinimumSize(QSize(200, 40));
	gameManagementBtn.setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Maximum);
	// TODO Красивое оформление
	gameManagementBtn.setStyleSheet("QPushButton { color : blue; }");
	gameManagementBtn.setText("Управление игрой");
	QObject::connect(&gameManagementBtn, SIGNAL(clicked()), SLOT(gameManagementBtnClick()));
}

void Puzzle::MainMenu::questionDesignerBtnClick() { emit needSceneChanged(1); }

void Puzzle::MainMenu::situationDesignerBtnClick() { std::cout << "Переход на конструктор обстановок\n"; }

void Puzzle::MainMenu::resultsViewerBtnClick() { std::cout << "Переход на просмотр результатов\n"; }

void Puzzle::MainMenu::gameManagementBtnClick() { std::cout << "Переход на управление игрой\n"; }