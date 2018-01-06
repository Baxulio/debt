#ifndef SQLHISTORYMODEL_H
#define SQLHISTORYMODEL_H

#include <QSqlRelationalTableModel>

class SqlHistoryModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    SqlHistoryModel(QObject *parent = 0);

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;
};

#endif // SQLHISTORYMODEL_H
