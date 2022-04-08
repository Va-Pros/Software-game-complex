
#ifndef SOFTWARE_GAME_COMPLEX_ADMIN_H
#define SOFTWARE_GAME_COMPLEX_ADMIN_H

#include "../GameManagement/backendLayer.h"
#include "../TcpServer/TcpServer.hpp"
#include "Themes.h"

#include <QObject>

class Admin : public QObject {
	Q_OBJECT
	Q_PROPERTY(TcpServer *server READ getServer CONSTANT)
	Q_PROPERTY(SessionSettings *sessionSettings READ getSettings CONSTANT)
	Q_PROPERTY(DataBase *database READ getDatabase CONSTANT)
	Q_PROPERTY(Themes *themes READ getThemes CONSTANT)

public:
	Admin();
	TcpServer *getServer();
	SessionSettings *getSettings();
	DataBase *getDatabase();
	Themes *getThemes();

	Q_INVOKABLE bool updateThemes();

private:
	Themes themes;
	TcpServer tcpServer;
	DataBase database;
	SessionSettings sessionSettings;
};
#endif	// SOFTWARE_GAME_COMPLEX_ADMIN_H
