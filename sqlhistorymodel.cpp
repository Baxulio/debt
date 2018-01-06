#include "sqlhistorymodel.h"
#include <QSqlRecord>
#include <QDebug>

SqlHistoryModel::SqlHistoryModel(QObject *parent):
    QSqlRelationalTableModel (parent)
{
    setEditStrategy(QSqlTableModel::OnManualSubmit);
    setJoinMode(QSqlRelationalTableModel::LeftJoin);
    setTable("history");

    setRelation(fieldIndex("debtor"),QSqlRelation("debtor","id", "name"));
    setRelation(fieldIndex("lender"),QSqlRelation("lender","id", "name"));
    setRelation(fieldIndex("paid_back_to"),QSqlRelation("lender","id", "name"));

    setSort(fieldIndex("borrowed_data"), Qt::DescendingOrder);
    select();
}

QVariant SqlHistoryModel::data(const QModelIndex &index, int role) const
{
    if (role < Qt::UserRole)
        return QSqlRelationalTableModel::data(index, role);

    const QSqlRecord sqlRecord = record(index.row());
    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlHistoryModel::roleNames() const
{
    QHash<int, QByteArray> names;

    for(int i=0; i<columnCount(); i++){
        names[Qt::UserRole + i] = headerData(i,Qt::Horizontal,Qt::DisplayRole).toByteArray();
        //qDebug()<<headerData(i,Qt::Horizontal,Qt::DisplayRole).toByteArray()<<"\n";
    }

    return names;
}
