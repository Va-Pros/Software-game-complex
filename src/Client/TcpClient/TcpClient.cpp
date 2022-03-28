#include "TcpClient.hpp"

TcpClient::TcpClient(QObject *parent) : QObject(parent) {
	connect(&_socket, &QTcpSocket::connected, this, &TcpClient::onConnected);
	connect(&_socket, &QTcpSocket::errorOccurred, this, &TcpClient::onErrorOccurred);
	connect(&_socket, &QTcpSocket::readyRead, this, &TcpClient::onReadyRead);
}

void TcpClient::connectToServer(const QString &ip, const QString &port) {
	_socket.connectToHost(ip, static_cast<quint16>(port.toUInt()));
}

void TcpClient::sendMessage(const QString &message) {
	qInfo() << message;
	_socket.write(message.toUtf8());
	_socket.flush();
}

void TcpClient::onConnected() {
	qInfo() << "Connected to host.";
	_isConnected = true;
}

void TcpClient::onReadyRead() {
	const auto message = _socket.readAll();
//     qInfo() << message;
    emit newMessage(message);
}

void TcpClient::onErrorOccurred(QAbstractSocket::SocketError error) { qWarning() << "Error:" << error; }
bool TcpClient::isConnected() { return _isConnected; }
