#include "database.h"

DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

DataBase::~DataBase()
{

}

/* Методы для подключения к базе данных
     * */
void DataBase::connectToDataBase()
{
	/* Перед подключением к базе данных производим проверку на её существование.
         * В зависимости от результата производим открытие базы данных или её восстановление
         * */
	if(!QFile("../war.db").exists()){
		this->restoreDataBase();
	} else {
		this->openDataBase();
	}
}

/* Методы восстановления базы данных
     * */
bool DataBase::restoreDataBase()
{
	// Если база данных открылась ...
	if(this->openDataBase()){
		// Производим восстановление базы данных
		return (this->createTable()) ? true : false;
	} else {
		qDebug() << "Не удалось восстановить базу данных";
		return false;
	}
	return false;
}

/* Метод для открытия базы данных
     * */
bool DataBase::openDataBase()
{
	/* База данных открывается по заданному пути
         * и имени базы данных, если она существует
         * */
	db = QSqlDatabase::addDatabase("QSQLITE");
	db.setHostName("WarDataBase");
	db.setDatabaseName("../war.db");
	if(db.open()){
		return true;
	} else {
		return false;
	}
}

/* Методы закрытия базы данных
     * */
void DataBase::closeDataBase()
{
	db.close();
}

/* Метод для создания таблицы в базе данных
     * */
bool DataBase::createTable()
{
	/* В данном случае используется формирование сырого SQL-запроса
         * с последующим его выполнением.
         * */
	QSqlQuery query;
	if(!query.exec( "CREATE TABLE TotalReport ("
					"id INTEGER PRIMARY KEY AUTOINCREMENT, "
					"name VARCHAR(255)    NOT NULL,"
					"platoon VARCHAR(255)    NOT NULL"
					" )"
					)){
		qDebug() << "DataBase: error of create TotalReport";
		qDebug() << query.lastError().text();
		return false;
	} else {
		return true;
	}
	return false;
}

/* Метод для вставки записи в базу данных
     * */
bool DataBase::inserIntoTable(const QVariantList &data)
{
	/* Запрос SQL формируется из QVariantList,
         * в который передаются данные для вставки в таблицу.
         * */
	QSqlQuery query;
	/* В начале SQL запрос формируется с ключами,
         * которые потом связываются методом bindValue
         * для подстановки данных из QVariantList
         * */
	query.prepare("INSERT INTO TotalReport ( name, platoon) "
				  "VALUES (:Name, :Platoon)");
	query.bindValue(":Name",       data[0].toString());
	query.bindValue(":Platoon",       data[1].toString());

	// После чего выполняется запросом методом exec()
	if(!query.exec()){
		qDebug() << "error insert into TotalReport";
		qDebug() << query.lastError().text();
		return false;
	} else {
		return true;
	}
	return false;
}

/* Второй метод для вставки записи в базу данных
     * */
bool DataBase::inserIntoTable(const QString &name, const QString &platoon)
{
	QVariantList data;
	data.append(name);
	data.append(platoon);

	if(inserIntoTable(data))
		return true;
	else
		return false;
}

/* Метод для удаления записи из таблицы
     * */
bool DataBase::removeRecord(const int id)
{
	// Удаление строки из базы данных будет производитсья с помощью SQL-запроса
	QSqlQuery query;

	// Удаление производим по id записи, который передается в качестве аргумента функции
	query.prepare("DELETE FROM TotalReport WHERE id= :ID ;");
	query.bindValue(":ID", id);

	// Выполняем удаление
	if(!query.exec()){
		qDebug() << "error delete row TotalReport";
		qDebug() << query.lastError().text();
		return false;
	} else {
		return true;
	}
	return false;
}