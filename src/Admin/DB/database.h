#ifndef DATABASE_H
#define DATABASE_H
#include "../AdminBackend/Themes.h"

#include <QDate>
#include <QDebug>
#include <QFile>
#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>

class DataBase : public QObject {
	Q_OBJECT

public:
	explicit DataBase(QObject *parent = nullptr);
	~DataBase() override;
	void connectToDataBase();

	Q_INVOKABLE qlonglong insertORUpdateIntoSituationTable(qlonglong id, const QString &name, int difficulty,
														   const QString &resources, const QString &net,
														   const QString &intruder, const QString &rights,
														   const QString &data);

	Q_INVOKABLE QList<QVariant> listAllSituations();

    Q_INVOKABLE QList<QVariant> searchSituations(const QString &name, int difficulty);

	Q_INVOKABLE static QMap<QString, QVariant> getAnySituation();

	Q_INVOKABLE bool deleteSituation(qlonglong id);

    Q_INVOKABLE bool deleteQuestion(qlonglong id);

	bool selectThemesAndNumberOfQuestions(Themes &themes);
	QStringList selectUniqueThemes();

public slots:
	static bool insertIntoTotalReportTable(const QVariantList &data);
	static int insertORUpdateIntoQuestionTable(int id, const QString &theme, int difficulty,
												const QString &description, int model,
												const QList<QList<QString>> &answers_list,
												const QList<QList<bool>> &is_correct, bool is_deleted);
	static QList<QVariant> selectAllFromQuestionTable(const QString &theme, const QString &description, int difficulty);
	static QList<QVariant> generateTest(const QList<QString> &theme, const QList<QList<int>> &count);

private:
	QSqlDatabase db;

private:
	bool openDataBase();
	void closeDataBase();
	static bool createTotalReportTable();
	static bool createQuestionTable();
	bool createSituationTable();
};

#endif	// DATABASE_H
