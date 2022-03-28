#include "QSqlRecord"
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
    for (const auto& table: db.tables()) {
        qDebug() << "found table: " << table;
        tables.insert(table);
    }
    if (tables.find("question") == tables.end())
        DataBase::createQuestionTable();
    if (tables.find("total_report") == tables.end())
        DataBase::createTotalReportTable();

    if (tables.find("situation") == tables.end())
        DataBase::createSituationTable();

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

bool DataBase::createSituationTable() {

    QSqlQuery query;
    if (!query.exec("CREATE TABLE Situation ("
                    "id           SERIAL      PRIMARY KEY,"
                    "name         TEXT        NOT NULL,"
                    "data         TEXT        NOT NULL,"
                    "difficulty   INTEGER     NOT NULL"
                    ")")) {
        qDebug() << "DataBase: error of create Situation";
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
            sub_str += ((i < list->length()) ? ("\"" + (*list)[i] + "\"") : ("null"));
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
    query.bindValue(":Platoon", data[1].toInt());
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Total_Report";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}
bool DataBase::insertORUpdateIntoQuestionTable(int id, const QString& theme, int difficulty, const QString& description,
                                               int model, const QList<QList<QString>>& answers_list,
                                               const QList<QList<bool>>& is_correct, bool is_deleted = false) {
    QSqlQuery query;
    if (id == -1)
        query.prepare("INSERT INTO Question (theme, difficulty, description, model, answers_list, is_correct)"
                      "VALUES(:Theme, :Difficulty, :Description, :Model, :Answers_list, :Is_correct)");
    else
        query.prepare(
                "update Question set (theme, difficulty, description, model, answers_list, is_correct, is_deleted)"
                "=(:Theme, :Difficulty, :Description, :Model, :Answers_list, :Is_correct, :Is_deleted) where id=:Id");
    query.bindValue(":Theme", theme);
    query.bindValue(":Difficulty", difficulty);
    query.bindValue(":Description", description);
    query.bindValue(":Model", model);
    query.bindValue(":Answers_list", qListToQString(answers_list));
    query.bindValue(":Is_correct", qListToQString(is_correct));
    query.bindValue(":Is_deleted", is_deleted);
    query.bindValue(":Id", id);
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Question";
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}
QList<QVariant> DataBase::generateTest(const QList<QString>& theme, const QList<QList<int>>& count) {
    QSet<QString> ids;
    QSqlQuery query;
    for (int i = 0; i < theme.length(); i++) {
        query.prepare("select  id from question where is_deleted = false AND theme LIKE \'%" +
                      theme[i] + "%\' AND difficulty = :Difficulty ORDER BY random()  LIMIT :Count ;");
        for (int j = 0; j < 3; j++) {
            query.bindValue(":Difficulty", j);
            query.bindValue(":Count", count[i][j]);
            if (!query.exec()) {
                qDebug() << "DataBase: generateTest (id)";
                qDebug() << query.lastError().text();
                return {};
            }
            while (query.next()) {
                ids.insert(query.value(i).toString());
            }
        }
    }
    QString id_list = "";
    for (auto i = ids.begin(); i != ids.end(); i++) {
        if (i != ids.begin())
            id_list += ",";
        id_list += *i;
    }
    query.prepare("(SELECT  id, theme, difficulty, description, model, unnest(answers_list), "
                  "array_length(answers_list,2) FROM Question WHERE id IN (" + id_list + ") AND model NOT IN (2,5))"
                  "UNION (SELECT  id, theme, difficulty, description, model, NULL, 0 FROM Question WHERE id IN "
                  "(" + id_list + ") AND model IN (2,5)) ORDER BY id;");
    if (!query.exec()) {
        qDebug() << query.executedQuery();
        qDebug() << "DataBase: generateTest (row)";
        qDebug() << query.lastError().text();
        return {};
    }
    QVariantList table;
    while (query.next()) {
        QVariantList row;
        for (int i = 0; i < 7; i++)
            row.append(query.value(i));
        table.append(row);
    }
    return table;
}
QList<QVariant> DataBase::selectAllFromQuestionTable(const QString& theme, const QString& description,
                                                     int difficulty) {
    QSqlQuery query;
    query.prepare("SELECT  id, theme, difficulty, description, model, unnest(answers_list), unnest(is_correct), "
                  "array_length(answers_list,2) FROM Question WHERE is_deleted = false AND theme LIKE \'%" + theme +
                  "%\' AND description LIKE \'%" + description + "%\' AND (difficulty = :Difficulty OR :Is_Any);");
    query.bindValue(":Difficulty", difficulty - 1);
    query.bindValue(":Is_Any", difficulty == 0);
//    qDebug() << query.executedQuery();
    if (!query.exec()) {
        qDebug() << "DataBase: selectAllFromQuestionTable";
        qDebug() << query.lastError().text();
        return {};
    }
    QVariantList table;
    while (query.next()) {
        QVariantList row;
        for (int i = 0; i < 8; i++)
            row.append(query.value(i));
        table.append(row);
//        break;
    }
    return table;
}

QList<QVariant> DataBase::listAllSituations() {

    QSqlQuery query;
    query.prepare("select * from situation order by id;");

    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Question";
        qDebug() << query.lastError().text();
        return {};
    }

    QVariantList table;
    while (query.next()) {
        QMap<QString, QVariant> map;
        for (int i = 0; i < query.record().count(); i++) {
            map[query.record().fieldName(i)] = query.value(i);
        }
        table.append(map);
    }
    return table;
}

qlonglong DataBase::insertORUpdateIntoSituationTable(qlonglong id, const QString& name, int difficulty, const QString& data) {
    qDebug() << "inserting " << id << " _ " << name << " _ " << data;

    QSqlQuery query;
    if (id == -1) {
        query.prepare("INSERT INTO Situation (name, data, difficulty) VALUES(:Name, :Data, :Difficulty);");
    } else {
        query.prepare(
            "update Situation set (name, data, difficulty)"
            "=(:Name, :Data, :Difficulty) where id=:Id");
    }
    query.bindValue(":Name", name);
    query.bindValue(":Data", data);
    query.bindValue(":Difficulty", difficulty);
    query.bindValue(":Id", id);
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Situation";
        qDebug() << query.lastError().text();
        return -1;
    }

    return query.lastInsertId().toLongLong();
}

bool DataBase::deleteSituation(qlonglong id) {
    if (id < 0) return false;

    QSqlQuery query;
    query.prepare("delete from situation where id=:Id;");
    query.bindValue(":Id", id);
    if (!query.exec()) {
        qDebug() << "DataBase: error deleting Situation " << id;
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}

QMap<QString, QVariant> DataBase::getAnySituation() {
    QSqlQuery query;
    query.prepare("select * from situation limit 1");

    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Question";
        qDebug() << query.lastError().text();
        return {};
    }

    while (query.next()) {
        QMap<QString, QVariant> map;
        for (int i = 0; i < query.record().count(); i++) {
            map[query.record().fieldName(i)] = query.value(i);
        }
        return map;
    }
    return {};
}
