
#include "Admin.h"

Admin::Admin() {
	database.connectToDataBase();
	if (!updateThemes()) {
		qDebug() << "DataBase: error selectThemesAndNumberOfQuestions";
	}
}
TcpServer *Admin::getServer() { return &tcpServer; }
SessionSettings *Admin::getSettings() { return &sessionSettings; }
DataBase *Admin::getDatabase() { return &database; }
Themes *Admin::getThemes() { return &themes; }

bool Admin::updateThemes() {
	return database.selectThemesAndNumberOfQuestions(themes);
}
