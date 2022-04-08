
#ifndef SOFTWARE_GAME_COMPLEX_TABLEMODEL_H
#define SOFTWARE_GAME_COMPLEX_TABLEMODEL_H


#include "TableElement.h"

#include <QAbstractTableModel>

class TableModel : public QAbstractTableModel {
public:
	int rowCount(const QModelIndex &parent = QModelIndex()) const override;
	int columnCount(const QModelIndex & = QModelIndex()) const override;
	QVariant data(const QModelIndex &index, int role) const override;
	static constexpr int COLUMN_COUNT = 6;

private:
	QVector<TableElement> users;
};


#endif	// SOFTWARE_GAME_COMPLEX_TABLEMODEL_H
