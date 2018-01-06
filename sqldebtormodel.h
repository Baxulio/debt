#ifndef SQLDEBTORMODEL_H
#define SQLDEBTORMODEL_H

#include <QSqlRelationalTableModel>

class SqlDebtorModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    SqlDebtorModel(QObject *parent=0);

    QVariant data(const QModelIndex &index, int role) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void append(const QString &name, const QString &surename, const QString  &phone, const QString &email, const QString  &comment, const int &address);
    Q_INVOKABLE void set(int row, const QString &name, const QString &surename, const QString  &phone, const QString &email, const QString  &comment, const int &address);
    Q_INVOKABLE void remove(int index);

    Q_INVOKABLE void filterModel(const QString filter, const QString columnName);
    Q_INVOKABLE void sortBy(const QString columnName);
private:
    int addressField;
};

#endif // SQLDEBTORMODEL_H
