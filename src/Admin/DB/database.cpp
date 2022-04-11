#include "database.h"

#include "QSqlRecord"
#include "utils/enums.h"


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
		qDebug() << db.lastError().text();
		return false;
	}
	QSet<QString> tables;
	for (const auto &table : db.tables()) {
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
                "difficulty   INTEGER     NOT NULL,"
                "resources    TEXT        NOT NULL,"
                "net          TEXT        NOT NULL,"
                "intruder     TEXT        NOT NULL,"
                "rights       TEXT        NOT NULL"
                ")")) {
    qDebug() << "DataBase: error of create Situation";
    qDebug() << query.lastError().text();
    return false;
}
return true;
}

template<class T>
int max_length(const QList<QList<T>> &list_list) {
	int _max = 0, tmp;
	for (const auto &list : list_list) {
		tmp = list.length();
		if (tmp > _max)
			_max = tmp;
	}
	return _max;
}
// может замакросить?
QString qListToQString(const QList<QList<QString>> &list_list) {
	QString str = "";
	int n		= max_length(list_list); // all arrays should have same size
	for (auto list = list_list.begin(); list != list_list.end(); list++) {
		if (list != list_list.begin())
			str += ", ";
		QString sub_str = "";
		for (int i = 0; i < n; i++) {
			if (i)
				sub_str += ", ";
			sub_str += ((i < list->length()) ? ("\"" + (*list)[i] + "\"") : ("null"));
		}
		str += "{" + sub_str + "}";
	}
	return "{" + str + "}";
}
QString qListToQString(const QList<QList<bool>> &list_list) {
	QString str = "";
	int n		= max_length(list_list); // all arrays should have same size
	for (auto list = list_list.begin(); list != list_list.end(); list++) {
		if (list != list_list.begin())
			str += ", ";
		QString sub_str = "";
		for (int i = 0; i < n; i++) {
			if (i)
				sub_str += ", ";
			sub_str += ((i < list->length() && (*list)[i]) ? "true" : "false");
		}
		str += "{" + sub_str + "}";
	}
	return "{" + str + "}";
}
bool DataBase::insertIntoTotalReportTable(const QVariantList &data) {
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

int DataBase::insertORUpdateIntoQuestionTable(int id, const QString &theme, int difficulty, const QString &description,
											   int model, const QList<QList<QString>> &answers_list,
											   const QList<QList<bool>> &is_correct, bool is_deleted = false) {

    qDebug() << "answers: " << qListToQString(answers_list) << "; " << answers_list[0].size();
    qDebug() << "correct: " << qListToQString(is_correct) << "; " << answers_list[0].size();

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
		return -1;
	}

	return id < 0 ? query.lastInsertId().toInt() : id;
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
                  "UNION ALL (SELECT  id, theme, difficulty, description, model, NULL, 0 FROM Question WHERE id IN "
                  "(" + id_list + ") AND model IN (2,5));");

    if (!query.exec()) {
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
    query.prepare("SELECT  id, theme, difficulty, description, model, unnest(answers_list) as variant, unnest(is_correct) as correctness "
                  ", array_length(answers_list, 2) FROM Question WHERE is_deleted = false AND theme LIKE \'%" + theme +
                  "%\' AND description LIKE \'%" + description + "%\' AND (difficulty = :Difficulty OR :Is_Any);");
    query.bindValue(":Difficulty", difficulty - 1);
    query.bindValue(":Is_Any", difficulty == 0);
//    qDebug() << query.executedQuery();
    if (!query.exec()) {
        qDebug() << "DataBase: selectAllFromQuestionTable";
        qDebug() << query.lastError().text();
        return {};
    }

    // Results look like this: `variants` and `correct` arrays' elements are spread one in line,
    // so we need to combine them manually
    //  id |   theme   | difficulty | description | model |  variant  | correct
    //----+-----------+------------+-------------+-------+-----------+--------
    //  1 | Theme1    |          1 | 1 + 1        |     1 | 2         | t
    //  1 | Theme1    |          1 | 1 + 1        |     1 | 3         | f
    QStringList arrayColumns = { "variant", "correctness" };
    QStringList helperColumns = { "array_length" };

    QMap<QVariant, QVariantMap> table;
	while (query.next()) {
        QVariant id = query.value("id");
        int listLength = query.value("array_length").toInt();
        if (table.contains(id)) { // only get array elements
            for (const auto& columnName : arrayColumns) {
                QVariant& columnValue = table[id][columnName];
                QList<QVariantList>& columnValueList = *reinterpret_cast<QList<QVariantList>*>(columnValue.data());
                QVariantList& lastList = columnValueList.last();
                QVariant newItem = query.value(columnName);
                if (lastList.size() < listLength) {
                    lastList.append(newItem);
                } else {
                    QVariantList newLastList = { newItem };
                    columnValueList.append(newLastList);
                }
            }
        } else {
            QMap<QString, QVariant> map;
            for (int i = 0; i < query.record().count(); i++) {
                QString columnName = query.record().fieldName(i);
                if (helperColumns.contains(columnName)) continue;
                if (arrayColumns.contains(columnName)) {
                    QList<QVariantList> arrayColumn = { { query.value(i) } };
                    map[columnName] = QVariant::fromValue(arrayColumn);
                } else {
                    map[columnName] = query.value(i);
                }
            }
            table[id] = map;
        }
	}

    QList<QVariant> result;
    for (QVariantMap& map : table.values()) {
        result.append(map);
    }

    return result;
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

qlonglong DataBase::insertORUpdateIntoSituationTable(
        qlonglong id, const QString& name, int difficulty,
        const QString& resources, const QString& net, const QString& intruder, const QString& rights,
        const QString& data
) {
    qDebug() << "inserting " << id << " _ " << name << " _ " << data;

    QSqlQuery query;
    if (id == -1) {
        query.prepare("INSERT INTO Situation (name, data, difficulty, resources, net, intruder, rights) "
                      "VALUES(:Name, :Data, :Difficulty, :Resources, :Net, :Intruder, :Rights);");
    } else {
        query.prepare(
            "update Situation set (name, data, difficulty, resources, net, intruder, rights)"
            "=(:Name, :Data, :Difficulty, :Resources, :Net, :Intruder, :Rights) where id=:Id");
    }
    query.bindValue(":Name", name);
    query.bindValue(":Data", data);
    query.bindValue(":Difficulty", difficulty);
    query.bindValue(":Resources", resources);
    query.bindValue(":Net", net);
    query.bindValue(":Intruder", intruder);
    query.bindValue(":Rights", rights);
    query.bindValue(":Id", id);
    if (!query.exec()) {
        qDebug() << "DataBase: error insert into Situation";
        qDebug() << query.lastError().text();
        return -1;
    }

    return query.lastInsertId().toLongLong();
}

bool DataBase::deleteSituation(qlonglong id) {
	if (id < 0)
		return false;

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
QStringList DataBase::selectUniqueThemes() {
	QSqlQuery query;
	QStringList themes;
	query.prepare("select distinct theme from Question where is_deleted=false;");
	if (!query.exec()) {
		qDebug() << "DataBase: error selecting theme";
		qDebug() << query.lastError().text();
		return themes;
	}
	while (query.next()) {
		themes.append(query.value(0).toString());
	}
	return themes;
}

bool DataBase::selectThemesAndNumberOfQuestions(Themes &themes) {
	QStringList uniqueThemes = selectUniqueThemes();
	themes.setModelThemes(uniqueThemes);
	QSqlQuery query;
	int difficulty = -1;
	int numberOfQuestions[NUMBER_OF_LEVEL_QUESTION_DIFFICULTY];

	for (int i = 0; i < uniqueThemes.count(); ++i) {
		for (int &numberOfQuestion : numberOfQuestions) {
			numberOfQuestion = 0;
		}
		query.prepare("select difficulty from Question where theme=:Theme and is_deleted=false;");
		query.bindValue(":Theme", uniqueThemes[i]);
		if (!query.exec()) {
			qDebug() << "DataBase: error selecting difficulty";
			qDebug() << query.lastError().text();
			return false;
		}
		while (query.next()) {
			difficulty = query.value(0).toInt();
			if (difficulty >= static_cast<int>(QuestionDifficulty::EASY) &&
				difficulty <= static_cast<int>(QuestionDifficulty::HARD)) {
				++numberOfQuestions[difficulty];
			} else {
				qDebug() << "Error difficulty is out of range";
				return false;
			}
		}
		themes.addTheme(uniqueThemes[i], numberOfQuestions);
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
bool DataBase::deleteQuestion(qlonglong id) {
    if (id < 0)
		return false;

	QSqlQuery query;
	query.prepare("update question set is_deleted = true where id=:Id;");
	query.bindValue(":Id", id);
	if (!query.exec()) {
		qDebug() << "DataBase: error deleting question " << id;
		qDebug() << query.lastError().text();
		return false;
	}
	return true;
}

QList<QVariant> DataBase::searchSituations(const QString& name, int difficulty) {

    QSqlQuery query;
    query.prepare("SELECT * FROM Situation WHERE name iLIKE \'%" + name +
                  "%\' AND (difficulty = :Difficulty OR :Is_Any);");
    query.bindValue(":Difficulty", difficulty);
    query.bindValue(":Is_Any", difficulty < 0);
//    qDebug() << query.executedQuery();
    if (!query.exec()) {
        qDebug() << "DataBase: selectAllFromQuestionTable";
        qDebug() << query.lastError().text();
        return {};
    }

    QVariantList situations;

    while (query.next()) {
        QMap<QString, QVariant> map;
        for (int i = 0; i < query.record().count(); i++) {
            map[query.record().fieldName(i)] = query.value(i);
        }
        situations.append(map);
    }

    return situations;
}
