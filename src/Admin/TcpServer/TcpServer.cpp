#include "TcpServer.hpp"

TcpClient::TcpClient(QObject *parent) : QObject(parent) {
	connect(&_server, &QTcpServer::newConnection, this, &TcpClient::onNewConnection);
	connect(this, &TcpClient::newMessage, this, &TcpClient::onNewMessage);
	if (_server.listen(QHostAddress::Any, 45000)) {
		qInfo() << "Listening ...";
	}
}

void TcpClient::sendMessage(const QString &message) { emit newMessage("Server: " + message.toUtf8()); }

void TcpClient::onNewConnection() {
	const auto client = _server.nextPendingConnection();
	if (client == nullptr) {
		return;
	}

	qInfo() << "New client connected.";

	_clients.insert(this->getClientKey(client), client);

	connect(client, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
	connect(client, &QTcpSocket::disconnected, this, &TcpClient::onClientDisconnected);
}

void TcpClient::onReadyRead() {
	const auto client = qobject_cast<QTcpSocket *>(sender());

	if (client == nullptr) {
		return;
	}

	const auto message = this->getClientKey(client).toUtf8() + ": " + client->readAll();

	emit newMessage(message);
}

void TcpClient::onClientDisconnected() {
	const auto client = qobject_cast<QTcpSocket *>(sender());

	if (client == nullptr) {
		return;
	}

	_clients.remove(this->getClientKey(client));
}

void TcpClient::onNewMessage(const QByteArray &ba) {
	qInfo() << ba;
	for (const auto &client : qAsConst(_clients)) {
		client->write(ba);
		client->flush();
	}
}

QString TcpClient::getClientKey(const QTcpSocket *client) const {
	return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
}
