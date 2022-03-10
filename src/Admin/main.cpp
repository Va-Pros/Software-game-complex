#include <QApplication>
#include <QTranslator>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <KLocalizedContext>
#include <QDirIterator>
#include <QQuickStyle>
#include "QuestionCreator/include/QuestionCreatorModel.h"
#include "Test/include/TypeInQuestion.h"
#include "QuestionCreator/include/QuestionSaver.h"
#include "QuestionCreator/include/QuestionThemes.h"
#include "QuestionCreator/include/QuestionDifficulty.h"
#include "TcpServer/TcpServer.hpp"


//template<class T>
//concept DerivesQObject = std::is_base_of<QObject, T>::value;

template<typename T>
int registerVersion1(const char *uri) {
    return qmlRegisterType<T>(uri, 1, 0, T::staticMetaObject.className());
}

template<typename T>
int registerInterfaceVersion1(const char *uri) {
    return qmlRegisterInterface<T>(uri, 1);
}

// TODO use plugins for each subsystem
void registerQmlTypes() {

    // QuestionCreator
    const char* questionCreatorUri = "QuestionCreator";
    registerVersion1<QuestionCreatorModel>(questionCreatorUri);
    registerVersion1<TypeInAnswer>(questionCreatorUri);
    registerVersion1<TypeInQuestion>(questionCreatorUri);
    registerInterfaceVersion1<QuestionTypeItem>(questionCreatorUri);
    registerInterfaceVersion1<QuestionTypeListModel>(questionCreatorUri);

    registerVersion1<QuestionThemes>(questionCreatorUri);
    registerInterfaceVersion1<QuestionThemeItem>(questionCreatorUri);
    registerInterfaceVersion1<QuestionThemeModel>(questionCreatorUri);
    registerVersion1<QuestionDifficulty>(questionCreatorUri);

    qmlRegisterSingletonType<QuestionSaver>(questionCreatorUri, 1, 0, "QuestionSaver", QuestionSaver::singletonProvider);
//    qmlRegisterSingletonType<QuestionThemes>(questionCreatorUri, 1, 0, "QuestionThemes", QuestionThemes::singletonProvider);

//    qmlregister
}

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

    registerQmlTypes();
    QQmlApplicationEngine engine;

	TcpServer tcpServer;

    engine.rootContext()->setContextProperty("server", &tcpServer);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:ui/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
