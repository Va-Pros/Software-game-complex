#include "DB/database.h"
#include "TcpServer/TcpServer.hpp"
#include <KLocalizedContext>
#include <QApplication>
#include <QDirIterator>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QTranslator>
//#define LIST_RESOURCES

int main(int argc, char** argv) {
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
#endif
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString& locale: uiLanguages) {
        const QString baseName = QString(":%1/%2").arg("i18n", "SGC_" + QLocale(locale).name());
        bool hasTranslation = translator.load(baseName);
        if (hasTranslation) {
            app.installTranslator(&translator);
            break;
        }
    }
//     app.setWindowIcon(QIcon("qrc:icons/icon.svg"));
    QQmlApplicationEngine engine;
    TcpServer tcpServer;
    DataBase database;
    database.connectToDataBase();
//    ListModel* model = new ListModel();

//    engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("database", &database);
    engine.rootContext()->setContextProperty("server", &tcpServer);
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:ui/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }
    return app.exec();
}
