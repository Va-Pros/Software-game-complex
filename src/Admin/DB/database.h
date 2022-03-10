#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>



class DataBase : public QObject
{
	Q_OBJECT
public:
	explicit DataBase(QObject *parent = 0);
	~DataBase();
	void connectToDataBase();

private:
	QSqlDatabase    db;

private:

	bool openDataBase();
	bool restoreDataBase();
	void closeDataBase();
	bool createTable();

public slots:
	bool inserIntoTable(const QVariantList &data);
	bool inserIntoTable(const QString &name, const QString &platoon);
	bool removeRecord(const int id);
};

#endif // DATABASE_H
