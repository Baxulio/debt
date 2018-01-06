#ifndef PRODUCTSMODEL_H
#define PRODUCTSMODEL_H

#include <QSqlQueryModel>
#include <QDateTime>

class ProductsModel : public QSqlQueryModel
{
    Q_OBJECT
    Q_PROPERTY(int curDebtor READ curDebtor WRITE setCurDebtor NOTIFY curDebtorChanged)

public:
    ProductsModel(QObject *parent=nullptr);

    int curDebtor() const;
    void setCurDebtor(const int &curDebtor);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int,QByteArray> roleNames() const;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void set(const bool &append, const int &id, const int &debtor, const QString &product, const double &quantity, const double &cost, const QString &comment_1, const QDateTime &borrowed_data, const int &lender, const double &paid_back,const QDateTime &paid_back_data, const QString &comment_2, const int &paid_back_to);
    Q_INVOKABLE void remove(const int &id);

signals:
    void curDebtorChanged();
private:
    int m_curDebtor;

};

#endif // PRODUCTSMODEL_H
