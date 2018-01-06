#ifndef SQLLENDERMODEL_H
#define SQLLENDERMODEL_H

#include <QSqlQueryModel>


class SqlLenderModel : public QSqlQueryModel
{
public:
    SqlLenderModel(QObject *parent = 0);
};

#endif // SQLLENDERMODEL_H
