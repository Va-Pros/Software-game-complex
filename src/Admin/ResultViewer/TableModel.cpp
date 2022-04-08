
#include "TableModel.h"

int TableModel::rowCount(const QModelIndex &parent) const {
	return users.size();
}

int TableModel::columnCount(const QModelIndex &) const {
	return COLUMN_COUNT;
}

QVariant TableModel::data(const QModelIndex &index, int role) const {
	// TODO
	return QVariant();
}