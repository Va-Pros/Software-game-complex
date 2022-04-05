#include "ListModel.h"

ListModel::ListModel(QObject *parent) : QObject(parent) {}
ListModel::~ListModel() = default;

[[nodiscard]] const QStringList &ListModel::getData() const { return data; }
void ListModel::setData(QStringList &newData) {
	data = newData;
	emit modelChanged();
}

void ListModel::add(const QString &element) {
	data.append(element);
	emit modelChanged();
}

void ListModel::remove(int index) {
	data.removeAt(index);
	emit modelChanged();
}