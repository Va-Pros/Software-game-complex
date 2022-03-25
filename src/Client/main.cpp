#include <QApplication>
#include <QTranslator>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <KLocalizedContext>
#include <QDirIterator>
#include <QQuickStyle>
#include <QIcon>
#include "TcpClient/TcpClient.hpp"
//#define LIST_RESOURCES

int main(int argc, char **argv) {

	QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps, true);
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#if defined(Q_OS_WIN)
	QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::RoundPreferFloor);
#endif

    QApplication app(argc, argv);

#ifdef Q_OS_WIN
	QQuickStyle::setStyle(QStringLiteral("org.kde.desktop"));
	QApplication::setStyle(QStringLiteral("breeze"));
#endif

#ifdef LIST_RESOURCES
    QDirIterator it(":", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << "res: " << it.next();
    }
    QDirIterator it(":", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << "res: " << it.next();
    }
#endif

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
// 	app.setWindowIcon(QIcon("../icon.svg"));
    QQmlApplicationEngine engine;

	TcpClient client;
	engine.rootContext()->setContextProperty("client", &client);
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:ui/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
