#include "sqldebtormodel.h"
#include <QSqlRecord>
#include <QDebug>
#include <QSqlError>

SqlDebtorModel::SqlDebtorModel(QObject *parent):
    QSqlRelationalTableModel (parent)
{
    setEditStrategy(QSqlTableModel::OnManualSubmit);
    setJoinMode(QSqlRelationalTableModel::LeftJoin);
    setTable("debtor");

    addressField=fieldIndex("address");
    setRelation(fieldIndex("address"),QSqlRelation("address","id", "name"));

    setSort(fieldIndex("name"), Qt::AscendingOrder);
    select();
}

QVariant SqlDebtorModel::data(const QModelIndex &index, int role) const
{
    if (role < Qt::UserRole)
        return QSqlRelationalTableModel::data(index, role);

    const QSqlRecord sqlRecord = record(index.row());
    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlDebtorModel::roleNames() const
{
    QHash<int, QByteArray> names;

    for(int i=0; i<columnCount(); i++){
        names[Qt::UserRole + i] = headerData(i,Qt::Horizontal,Qt::DisplayRole).toByteArray();
    }

    return names;
}

QVariantMap SqlDebtorModel::get(int row) const
{
    return { {"name", record(row).value(fieldIndex("name")).toString()},
        {"surename",   record(row).value(fieldIndex("surename")).toString()},
        {"phone",      record(row).value(fieldIndex("phone")).toString()},
        {"email",      record(row).value(fieldIndex("e_mail")).toString()},
        {"comment",    record(row).value(fieldIndex("comment")).toString()},
        {"address",    record(row).value(fieldIndex("address")).toString()} };
}

void SqlDebtorModel::append(const QString &name, const QString &surename, const QString &phone, const QString &email, const QString &comment, const int &address)
{
    const int n=rowCount();

    insertRows(n, 1);
    set(n,name,surename,phone,email,comment,address);
}

void SqlDebtorModel::set(int row, const QString &name, const QString &surename, const QString &phone, const QString &email, const QString &comment, const int &address)
{
    const int n=row;
    setData(index(n,fieldIndex("name")),name,Qt::EditRole);
    setData(index(n,fieldIndex("surename")),surename,Qt::EditRole);
    setData(index(n,fieldIndex("phone")),phone,Qt::EditRole);
    setData(index(n,fieldIndex("e_mail")),email,Qt::EditRole);
    setData(index(n,fieldIndex("comment")),comment,Qt::EditRole);
    setData(index(n,addressField),address,Qt::EditRole);

    submitAll();
}

void SqlDebtorModel::remove(int index)
{
    removeRows(index,1, QModelIndex());
    submitAll();
}

void SqlDebtorModel::filterModel(const QString filter, const QString columnName)
{
    setFilter("name like 'Ba%'");
}

void SqlDebtorModel::sortBy(const QString columnName)
{
    sort(fieldIndex(columnName),Qt::AscendingOrder);
}
