#ifndef TCPSERVER_HPP
#define TCPSERVER_HPP

#include <QHash>
#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QVariantList>
#include "../DB/database.h"

#define GAME_ROLE_ATTACKER 0
#define GAME_ROLE_DEFENDER 1

class TcpServer : public QObject {
Q_OBJECT

public:
    explicit TcpServer(QObject* parent = nullptr);

signals:

    void newMessage(QTcpSocket* sender, const QByteArray &ba);

public slots:

    void onStart();//or resumeAccepting?
    void onStop();//or pauseAccepting?
    bool isServerAvailable();

private slots:

    void onNewConnection();

    void onReadyRead();

    void onClientDisconnected();

    void onNewMessage(QTcpSocket* sender, const QByteArray &ba);


private:
    QString getClientKey(const QTcpSocket* client) const;

private:
    QTcpServer _server;
    QHash<QString, QTcpSocket*> _clients;
    bool _isServerAvailable = false;
    QList<QPair<QTcpSocket*, QTcpSocket*>> gameMapping;
    bool nextAttacker = true;
//    DataBase database;
};

#endif    // TCPSERVER_HPP