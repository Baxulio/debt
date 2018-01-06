#include "productsmodel.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QSqlRecord>

QString str;

ProductsModel::ProductsModel(QObject *parent):
    QSqlQueryModel (parent)
{
    //setQuery(str);
    //qDebug()<<lastError().text();
}

int ProductsModel::curDebtor() const
{
    return m_curDebtor;
}

void ProductsModel::setCurDebtor(const int &curDebtor)
{
    if (curDebtor == m_curDebtor)
        return;
    m_curDebtor=curDebtor;

    str=QString("SELECT h.id,h.product,h.quantity,h.cost,h.comment_1,h.borrowed_data,h.lender,h.paid_back,h.paid_back_data,h.comment_2,h.paid_back_to, l1.name as lender_name,l2.name as paid_back_to_name"
                " FROM ((history h"
                " INNER JOIN lender l1 ON h.lender = l1.id)"
                " LEFT JOIN lender l2 ON h.paid_back_to = l2.id)"
                " WHERE h.debtor=%1"
                " ORDER BY h.borrowed_data DESC").arg(m_curDebtor);
    setQuery(str);
    qDebug()<<m_curDebtor;
    emit curDebtorChanged();
}

QVariant ProductsModel::data(const QModelIndex &index, int role) const
{
    if (role < Qt::UserRole)
        return QSqlQueryModel::data(index, role);

    const QSqlRecord sqlRecord = record(index.row());

    if(role==Qt::UserRole+5){
        QDateTime date = QDateTime::fromString(sqlRecord.value(role - Qt::UserRole).toString(),"yyyy-MM-dd hh:mm:ss");
        return date.date().toString(Qt::LocaleDate);
    }
    else if(role==Qt::UserRole+13)
    {
        QDateTime time = QDateTime::fromString(sqlRecord.value(role - Qt::UserRole-8).toString(),"yyyy-MM-dd hh:mm:ss");
        return time.time().toString();
    }
    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> ProductsModel::roleNames() const
{
    QHash<int, QByteArray> names;

    int i=0, count=columnCount();
    while(i<count){
        names[Qt::UserRole + i] = headerData(i,Qt::Horizontal,Qt::DisplayRole).toByteArray();
        i++;
    }
    names[Qt::UserRole + i] = "borrowed_time";

    qDebug()<<names;
    return names;
}

QVariantMap ProductsModel::get(int row) const
{
    QVariantMap map;
    QHash<int, QByteArray> hash=roleNames();

    for(int i=Qt::UserRole; i<Qt::UserRole+13; i++)
    {
        map.insert(hash.value(i),data(index(row,i-Qt::UserRole)));
        qDebug()<<hash.value(i)<<" "<<data(index(row,i-Qt::UserRole))<<"\n";
    }

    return map;
}

void ProductsModel::set(const bool &append, const int &id, const int &debtor, const QString &product, const double &quantity, const double &cost, const QString &comment_1, const QDateTime &borrowed_data, const int &lender, const double &paid_back,const QDateTime &paid_back_data, const QString &comment_2, const int &paid_back_to)
{
    QSqlQuery query;
    if(append)query.prepare("INSERT INTO history (debtor, product, quantity, cost, comment_1, borrowed_data, lender, paid_back,paid_back_data, comment_2, paid_back_to) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    else if(!paid_back)query.prepare("UPDATE history SET debtor=?, product=?, quantity=?, cost=?, comment_1=?, borrowed_data=?, lender=? WHERE history.id=?");
    else query.prepare("UPDATE history SET paid_back=?,paid_back_data=?, comment_2=?, paid_back_to=? WHERE history.id=?");

    if(append || paid_back==0)
    {
        query.addBindValue(debtor);
        query.addBindValue(product);
        query.addBindValue(quantity);
        query.addBindValue(cost);
        query.addBindValue(comment_1);
        query.addBindValue(borrowed_data.toString("yyyy-MM-dd hh:mm:ss"));
        query.addBindValue(lender);
    }
    if(paid_back!=0 || append)
    {
        query.addBindValue(paid_back);
        query.addBindValue(paid_back_data.toString("yyyy-MM-dd hh:mm:ss"));
        query.addBindValue(comment_2);
        query.addBindValue(paid_back_to);
    }

    if(!append)query.addBindValue(id);

    if(!query.exec()){

        qDebug()<<query.lastError();
    }
    setQuery(str);
}

void ProductsModel::remove(const int &id)
{
    QSqlQuery query("DELETE FROM history WHERE history.id=" + QString::number(id));
    if(!query.exec()){

        qDebug()<<query.lastError();
    }
    setQuery(str);
}

