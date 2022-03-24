#include "database.h"
DataBase::DataBase(QObject* parent) : QObject(parent) {}
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
        qDebug() << db.lastError().text();
        return false;
    }
    QSet<QString> tables;
    for (const auto& table: db.tables())
        tables.insert(table);
    if (tables.find("question") == tables.end())
        DataBase::createQuestionTable();
    if (tables.find("total_report") == tables.end())
        DataBase::createTotalReportTable();
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
template<class T>
int max_length(const QList<QList<T>>& list_list) {
    int _max = 0, tmp;
    for (const auto& list: list_list) {
        tmp = list.length();
        if (tmp > _max)
            _max = tmp;
    }
    return _max;
}
// может замакросить?
QString qListToQString(const QList<QList<QString>>& list_list) {
    QString str = "";
    int n = max_length(list_list);
    for (auto list = list_list.begin(); list != list_list.end(); list++) {
        if (list != list_list.begin())
            str += ", ";
        QString sub_str = "";
        for (int i = 0; i < n; i++) {
            if (i)sub_str += ", ";
            sub_str += "\"" + ((i < list->length()) ? ((*list)[i]) : ("")) + "\"";
        }
        str += "{" + sub_str + "}";
    }
    return "{" + str + "}";
}
QString qListToQString(const QList<QList<bool>>& list_list) {
    QString str = "";
    int n = max_length(list_list);
    for (auto list = list_list.begin(); list != list_list.end(); list++) {
        if (list != list_list.begin())
            str += ", ";
        QString sub_str = "";
        for (int i = 0; i < n; i++) {
            if (i)sub_str += ", ";
            sub_str += ((i < list->length() && (*list)[i]) ? "true" : "false");
        }
        str += "{" + sub_str + "}";
    }
    return "{" + str + "}";
}
bool DataBase::insertIntoTotalReportTable(const QVariantList& data) {
    QSqlQuery query;
    query.prepare("INSERT INTO Total_Report (name , platoon ) "
                  "VALUES					(:Name, :Platoon) ");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Platoon", data[1].toString());
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Total_Report";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}
bool DataBase::insertIntoQuestionTable(const QString& theme, int difficulty, const QString& description,
                                       int model, const QList<QList<QString>>& answers_list,
                                       const QList<QList<bool>>& is_correct) {
    QSqlQuery query;
    query.prepare("INSERT INTO Question (theme, difficulty, description, model, answers_list, is_correct)"
                  "VALUES(:Theme, :Difficulty, :Description, :Model, :Answers_list, :Is_correct)");
    query.bindValue(":Theme", theme);
    query.bindValue(":Difficulty", difficulty);
    query.bindValue(":Description", description);
    query.bindValue(":Model", model);
    query.bindValue(":Answers_list", qListToQString(answers_list));
    query.bindValue(":Is_correct", qListToQString(is_correct));
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Question";
        qDebug() << query.lastError().text();
        return false;
    }
    qDebug() << "ok";
    return true;
}
QList<QVariant> DataBase::selectAllFromQuestionTable(const QString& theme, const QString& description,
                                                     int difficulty) {
    QSqlQuery query;
    query.prepare("select  id, theme, difficulty, description, model, unnest(answers_list), unnest(is_correct), "
                  "array_length(answers_list,2) from question where is_deleted = false AND theme LIKE \'%" + theme +
                  "%\';");// AND difficulty = \'%" + char(difficulty + '0') + "%\';");
//    query.bindValue(":Theme", theme);
    qDebug() << query.exec();
    QVariantList table;
    while (query.next()) {
        QVariantList row;
        for (int i = 0; i < 8; i++)
            row.append(query.value(i).toString());
        table.append(row);
//        break;
    }
    return table;
}
