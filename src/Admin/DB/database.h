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

class DataBase : public QObject {
Q_OBJECT
public:
    explicit DataBase(QObject* parent = 0);
    ~DataBase() override;
    void connectToDataBase();
public slots:
    static bool insertIntoTotalReportTable(const QVariantList& data);
    static bool
    insertIntoQuestionTable(const QString& theme, const int difficulty, const QString& description, const int model,
                            const QList<QList<QString>>& answers_list, const QList<QList<bool>>& is_correct);
private:
    QSqlDatabase db;
private:
    bool openDataBase();
    void closeDataBase();
    static bool createTotalReportTable();
    static bool createQuestionTable();
};

#endif    // DATABASE_H
