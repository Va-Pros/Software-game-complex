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
    ~DataBase() override;
    void connectToDataBase();

public slots:
    bool insertIntoTotalReportTable(const QVariantList &data);
    bool insertIntoQuestionTable(const QVariantList &data);

private:
    QSqlDatabase    db;

private:
    bool openDataBase();
    void closeDataBase();
    bool createTotalReportTable();
    bool createQuestionTable();
};

#endif // DATABASE_H
