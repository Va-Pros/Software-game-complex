#include "TcpServer.hpp"
#include "../DB/database.h"
#include<string>
#include <QJsonDocument>
#include <QJsonObject>

TcpServer::TcpServer(QObject* parent) : QObject(parent) {

//    qDebug()
    connect(&_server, &QTcpServer::newConnection, this, &TcpServer::onNewConnection);
    connect(this, &TcpServer::newMessage, this, &TcpServer::onNewMessage);
//    database.connectToDataBase();
}

void TcpServer::onNewConnection() {
    const auto client = _server.nextPendingConnection();
    if (client == nullptr) {
        return;
    }

    qInfo() << "New client connected." << this->getClientKey(client);

    _clients.insert(this->getClientKey(client), client);

    connect(client, &QTcpSocket::readyRead, this, &TcpServer::onReadyRead);
    connect(client, &QTcpSocket::disconnected, this, &TcpServer::onClientDisconnected);
}

void TcpServer::onReadyRead() {
    const auto client = qobject_cast<QTcpSocket*>(sender());

    if (client == nullptr) {
        return;
    }

    QByteArray request = client->readAll();
    QList<QByteArray> data = request.split(';');
    QByteArray back_message;
    if (!data.empty()) {
        if (data[0] == "0") {
            QVariantList row;
            row.append(data[1]);
            row.append(data[2]);
            DataBase::insertIntoTotalReportTable(row);
            back_message = "0";
            QList<QVariant> questions = DataBase::generateTest({""}, {{100, 100, 100}});
            for (const auto& q: questions)
                back_message += ";" + q.toString().toUtf8();
        } else if (data[0] == "1") {
            qInfo() << request;
        }
        else if (data[0] == "666") {
            auto situation = DataBase::getAnySituation();
            QJsonObject obj;
            obj["id"] = QJsonValue(situation["id"].toLongLong());
            obj["role"] = QJsonValue(nextAttacker ? GAME_ROLE_ATTACKER : GAME_ROLE_DEFENDER);
            obj["data"] = QJsonValue(situation["data"].toString());
            back_message = "666;" + QJsonDocument(obj).toJson();
            if (nextAttacker) {
                gameMapping.append(QPair(client, (QTcpSocket*) nullptr));
            } else {
                gameMapping.last().second = client;
            }
            nextAttacker = !nextAttacker;
        }
    }
    emit newMessage(client, back_message);
}

void TcpServer::onClientDisconnected() {
    const auto client = qobject_cast<QTcpSocket*>(sender());

    if (client == nullptr) {
        return;
    }

    _clients.remove(this->getClientKey(client));
}
void TcpServer::onNewMessage(QTcpSocket* sender, const QByteArray& ba) {
//    const auto client = qobject_cast<QTcpSocket*>(sender());
//    qInfo() << "onNewMessage" << ba;
    sender->write(ba);
    sender->flush();
}

QString TcpServer::getClientKey(const QTcpSocket* client) const {
    return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
}

void TcpServer::onStart() {
    if (_server.listen(QHostAddress::Any, 45000)) {
        qInfo() << "Listening ...";
        _isServerAvailable = true;
    }
}

void TcpServer::onStop() {
    qInfo() << "Stop listening";
    _server.close();
    for (auto client: qAsConst(_clients)) {
        //		qInfo() << this->getClientKey(client).toUtf8();
        client->deleteLater();
    }
    gameMapping.clear();
    _isServerAvailable = false;
}

bool TcpServer::isServerAvailable() { return _isServerAvailable; }
