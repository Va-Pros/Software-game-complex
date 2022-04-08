#ifndef SOFTWARE_GAME_COMPLEX_LISTMODEL_H
#define SOFTWARE_GAME_COMPLEX_LISTMODEL_H


#include <QObject>
class ListModel : public QObject {
	Q_OBJECT
	Q_PROPERTY(QStringList data READ getData WRITE setData NOTIFY modelChanged)

public:
	explicit ListModel(QObject *parent = nullptr);
	~ListModel() override;

	[[nodiscard]] const QStringList &getData () const;
	void setData(QStringList &newData);
	Q_INVOKABLE void add(const QString &element);
	Q_INVOKABLE void remove(int index);

signals:
	void modelChanged();

private:
	QStringList data;
};


#endif	// SOFTWARE_GAME_COMPLEX_LISTMODEL_H
