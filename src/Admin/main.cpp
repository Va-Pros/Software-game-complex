#include <QApplication>
#include <QTranslator>
#include "Admin/admin.h"

int main(int argc, char **argv) {
	QApplication app(argc, argv);

    QTranslator translator;

    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = QString(":%1/%2").arg("i18n", "SGC_" + QLocale(locale).name());

        bool hasTranslation = translator.load(baseName);
        if (hasTranslation) {
            app.installTranslator(&translator);
            break;
        }
    }

	Puzzle::Admin admin;
	admin.show();
	return app.exec();
}