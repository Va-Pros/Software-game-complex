#ifndef DATABASE_H
#define DATABASE_H
#include <QDate>
#include <QDebug>
#include <QFile>
#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include "../AdminBackend/Themes.h"

class DataBase : public QObject {
	Q_OBJECT

public:
	explicit DataBase(QObject *parent = nullptr);
	~DataBase() override;
	void connectToDataBase();

	Q_INVOKABLE qlonglong insertORUpdateIntoSituationTable(qlonglong id, const QString &name, int difficulty,
														   const QString &data);

	Q_INVOKABLE QList<QVariant> listAllSituations();

	Q_INVOKABLE bool deleteSituation(qlonglong id);

	bool selectThemesAndNumberOfQuestions(Themes &themes);
	QStringList selectUniqueThemes();

public slots:
	static bool insertIntoTotalReportTable(const QVariantList &data);
	static bool insertORUpdateIntoQuestionTable(int id, const QString &theme, int difficulty,
												const QString &description, int model,
												const QList<QList<QString>> &answers_list,
												const QList<QList<bool>> &is_correct, bool is_deleted);
	static QList<QVariant> selectAllFromQuestionTable(const QString &theme, const QString &description, int difficulty);

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
