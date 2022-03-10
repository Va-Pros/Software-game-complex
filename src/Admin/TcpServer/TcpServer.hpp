#ifndef TCPSERVER_HPP
#define TCPSERVER_HPP

#include <QHash>
#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>

class TcpServer : public QObject {
	Q_OBJECT

public:
	explicit TcpServer(QObject *parent = nullptr);

signals:
	void newMessage(const QByteArray &ba);

public slots:
	void sendMessage(const QString &message);
	void onStart();//or resumeAccepting?
	void onStop();//or pauseAccepting?
	bool isServerAvailable();

private slots:
	void onNewConnection();
	void onReadyRead();
	void onClientDisconnected();
	void onNewMessage(const QByteArray &ba);


private:
	QString getClientKey(const QTcpSocket *client) const;

private:
	QTcpServer _server;
	QHash<QString, QTcpSocket *> _clients;
	bool _isServerAvailable = false;
};

#endif	// TCPSERVER_HPP