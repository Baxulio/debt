#include "sqllendermodel.h"
#include <QSqlError>
#include <QSqlQuery>

SqlLenderModel::SqlLenderModel(QObject *parent):
    QSqlQueryModel (parent)
{
    QSqlQuery query;
    if (!query.exec("SELECT name FROM lender"))
        qFatal("Lender SELECT query failed: %s", qPrintable(query.lastError().text()));

    setQuery(query);
    if (lastError().isValid())
        qFatal("Cannot set query on SqlLenderModel: %s", qPrintable(lastError().text()));
}
