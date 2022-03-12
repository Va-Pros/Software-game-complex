#include "database.h"

DataBase::DataBase(QObject* parent) : QObject(parent) {

}

DataBase::~DataBase() {

}

/* Методы для подключения к базе данных
 * */
void DataBase::connectToDataBase() {
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
bool DataBase::restoreDataBase() {
    if (this->openDataBase()) {
        return (this->createTotalReportTable() && this->createQuestionTable());
    }
    qDebug() << "Не удалось восстановить базу данных";
    return false;
}

/* Метод для открытия базы данных
 * */
bool DataBase::openDataBase() {
    /* База данных открывается по заданному пути
     * и имени базы данных, если она существует
     * */
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("WarDataBase");
    db.setDatabaseName("../war.db");

    return db.open();
}

/* Методы закрытия базы данных
 * */
void DataBase::closeDataBase() {
    db.close();
}

/* Метод для создания основной таблицы в базе данных
 * */
bool DataBase::createTotalReportTable() {
    /* В данном случае используется формирование сырого SQL-запроса
     * с последующим его выполнением.
     * */
    QSqlQuery query;
    if (!query.exec("CREATE TABLE TotalReport ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "name VARCHAR(255)      NOT NULL,"
                    "platoon VARCHAR(16)    NOT NULL"
                    //todo: testReport + gameReport
                    " )"
    )) {
        qDebug() << "DataBase: error of create TotalReport";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}

/* Метод для создания таблицы устройств в базе данных
 * */
bool DataBase::createQuestionTable() {
    /* В данном случае используется формирование сырого SQL-запроса
     * с последующим его выполнением.
     * */
    QSqlQuery query;
    if (!query.exec("CREATE TABLE Question ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "theme VARCHAR(255)     NOT NULL,"
                    "difficulty INTEGER     NOT NULL,"
                    "text VARCHAR(255)      NOT NULL,"
                    "isActive BOOLEAN       NOT NULL,"
                    "type VARCHAR(16)       NOT NULL,"
                    "isDeleted BOOLEAN      NOT NULL"
                    " )"
    )) {
        qDebug() << "DataBase: error of create Question";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}

/* Метод для вставки записи в основную таблицу
 * */
bool DataBase::insertIntoTotalReportTable(const QVariantList &data) {
    /* Запрос SQL формируется из QVariantList,
     * в который передаются данные для вставки в таблицу.
     * */
    QSqlQuery query;
    /* В начале SQL запрос формируется с ключами,
     * которые потом связываются методом bindValue
     * для подстановки данных из QVariantList
     * */
    query.prepare("INSERT INTO TotalReport (name, platoon) "
                  "VALUES (:Name, :Platoon)");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Platoon", data[1].toString());
    // После чего выполняется запросом методом exec()
    if (!query.exec()) {
        qDebug() << "error insert into TotalReport";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}

/* Метод для вставки записи в таблицу устройств
 * */
bool DataBase::insertIntoQuestionTable(const QVariantList &data) {
    /* Запрос SQL формируется из QVariantList,
     * в который передаются данные для вставки в таблицу.
     * */
    QSqlQuery query;
    /* В начале SQL запрос формируется с ключами,
     * которые потом связываются методом bindValue
     * для подстановки данных из QVariantList
     * */
    query.prepare("INSERT INTO Question (theme, difficulty, text, isActive, type, isDeleted )"
                  "VALUES (:Theme, :Difficulty, :Text, :IsActive, :Type, :IsDeleted )");
    query.bindValue(":Theme", data[0].toString());
    query.bindValue(":Difficulty", data[1].toString());
    query.bindValue(":Text", data[2].toString());
    query.bindValue(":IsActive", data[3].toString());
    query.bindValue(":Type", data[4].toString());
    query.bindValue(":IsDeleted", data[5].toString());
    // После чего выполняется запросом методом exec()
    if (!query.exec()) {
        qDebug() << "error insert into Question";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}