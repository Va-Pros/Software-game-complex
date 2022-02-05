#include <QApplication>
#include <QTranslator>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <KLocalizedContext>
#include <QDirIterator>
#include "QuestionCreator/include/QuestionCreatorModel.h"
#include "Test/include/TypeInQuestion.h"
#include "QuestionCreator/include/QuestionSaver.h"
#include "QuestionCreator/include/QuestionThemes.h"
#include "QuestionCreator/include/QuestionDifficulty.h"
//#include "QuestionCreator/include/QuestionTypeItem.h"
//#include "QuestionCreator/include/QuestionTypeListModel.h"

template<class T>
concept DerivesQObject = std::is_base_of<QObject, T>::value;

template<DerivesQObject T>
int registerVersion1(const char *uri) {
    return qmlRegisterType<T>(uri, 1, 0, T::staticMetaObject.className());
}

template<DerivesQObject T>
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
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

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

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(QStringLiteral("qrc:ui/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}