#include "Admin/admin.h"

#include <QtWidgets>

Puzzle::Admin::Admin() {
	QRect screen = QGuiApplication::primaryScreen()->availableGeometry();
	this->resize(screen.width(), screen.height());
	this->setCentralWidget(&sceneContainer);

	QObject::connect(&mainMenuScene, SIGNAL(needSceneChanged(int)), SLOT(changeScene(int)));

	// Добавление сцен
	sceneContainer.addWidget(&mainMenuScene);
	sceneContainer.addWidget(&questionDesignerScene);

	sceneContainer.setCurrentIndex(0);
}

void Puzzle::Admin::changeScene(int idx) { sceneContainer.setCurrentIndex(idx); }