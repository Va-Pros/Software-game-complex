#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent) {}

DataBase::~DataBase() = default;

void DataBase::connectToDataBase() { this->openDataBase(); }

bool DataBase::openDataBase() {
// 	qDebug() << QSqlDatabase::drivers();
	db = QSqlDatabase::addDatabase("QPSQL");

	db.setHostName("localhost");
	db.setUserName("postgres");
	db.setPassword("123");
	db.setPort(5432);

	if (!db.open()) {
		qDebug() << db.lastError();
		return false;
	}
	QSet<QString> tables;
	for(auto table: db.tables())
		tables.insert(table);
	if (tables.find("question") == tables.end())
		this->createQuestionTable();
	if (tables.find("total_report") == tables.end())
		this->createTotalReportTable();
	return true;
}

void DataBase::closeDataBase() { db.close(); }

bool DataBase::createTotalReportTable() {
	QSqlQuery query;
	if (!query.exec("CREATE TABLE Total_Report ("
					"id      SERIAL  PRIMARY KEY, "
					"name    text    NOT NULL,"
					"platoon text    NOT NULL"
					// todo: Test_Report
					// todo: Game_Report
					" )")) {
		qDebug() << "DataBase: error of create TotalReport";
		qDebug() << query.lastError().text();
		return false;
	}
	return true;
}

bool DataBase::createQuestionTable() {
	QSqlQuery query;
	if (!query.exec("CREATE TABLE Question ("
					"id           SERIAL      PRIMARY KEY,"
					"theme        TEXT        NOT NULL,"
					"difficulty   INTEGER     NOT NULL,"
					"description  TEXT        NOT NULL,"
					"model        INTEGER     NOT NULL,"
					"answers_list text[][]    NOT NULL,"
					"is_correct   boolean[][] NOT NULL,"
					"is_deleted   boolean     DEFAULT false"
					")")) {
		qDebug() << "DataBase: error of create Question";
		qDebug() << query.lastError().text();
		return false;
	}
	return true;
}

bool DataBase::insertIntoTotalReportTable(const QVariantList &data) {
	QSqlQuery query;
	query.prepare("INSERT INTO Total_Report (name , platoon ) "
				  "VALUES					(:Name, :Platoon) ");
	query.bindValue(":Name",    data[0].toString());
	query.bindValue(":Platoon", data[1].toString());
	if (!query.exec()) {
		qDebug() << "DataBase: error insert into Tota_lReport";
		qDebug() << query.lastError().text();
		return false;
	}
	return true;
}

bool DataBase::insertIntoQuestionTable(const QVariantList &data) {
	QSqlQuery query;
	query.prepare("INSERT INTO Question (theme , difficulty , description , model , answers_list , is_correct , is_deleted ) "
				  "VALUES 				(:Theme, :Difficulty, :Description, :Model, :Answers_list, :Is_correct, :Is_deleted) ");
	query.bindValue(":Theme",        data[0].toString());
	query.bindValue(":Difficulty",   data[1].toString());
	query.bindValue(":Description",  data[2].toString());
	query.bindValue(":Model",        data[3].toString());
	query.bindValue(":Answers_list", data[4].toString());
	query.bindValue(":Is_correct",   data[5].toString());
	query.bindValue(":Is_deleted",   data[6].toString());
	if (!query.exec()) {
		qDebug() << "DataBase: error insert into Question";
		qDebug() << query.lastError().text();
		return false;
	}
	return true;
}
