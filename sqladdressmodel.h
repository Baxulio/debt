#ifndef SQLADDRESSMODEL_H
#define SQLADDRESSMODEL_H

#include <QSqlQueryModel>

class SqlAddressModel : public QSqlQueryModel
{
public:
    SqlAddressModel(QObject *parent = 0);
};

#endif // SQLADDRESSMODEL_H
