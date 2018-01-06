#include "sqladdressmodel.h"
#include <QSqlError>
#include <QSqlQuery>

SqlAddressModel::SqlAddressModel(QObject *parent):
    QSqlQueryModel (parent)
{
    QSqlQuery query;
    if (!query.exec("SELECT name FROM address"))
        qFatal("Address SELECT query failed: %s", qPrintable(query.lastError().text()));

    setQuery(query);
    if (lastError().isValid())
        qFatal("Cannot set query on SqlAddressModel: %s", qPrintable(lastError().text()));
}
