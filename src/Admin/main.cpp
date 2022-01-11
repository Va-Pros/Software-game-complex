#include <QApplication>
#include "Admin/admin.h"

int main(int argc, char **argv) {
	QApplication app(argc, argv);
	Puzzle::Admin admin;
	admin.show();
	return app.exec();
}