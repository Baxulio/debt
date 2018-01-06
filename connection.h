#ifndef CONNECTION_H
#define CONNECTION_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>

static void createConnection()
{
    QSqlDatabase database = QSqlDatabase::database();
    if (!database.isValid()) {
        database = QSqlDatabase::addDatabase("QSQLITE");
        if (!database.isValid())
            qFatal("Cannot add database: %s", qPrintable(database.lastError().text()));
    }

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if (!writeDir.mkpath("."))
        qFatal("Failed to create writable directory at %s", qPrintable(writeDir.absolutePath()));

    // Ensure that we have a writable location on all devices.
    const QString fileName = writeDir.absolutePath() + "/bahman_v2.0.db";
    // When using the SQLite driver, open() will create the SQLite database if it doesn't exist.
    database.setDatabaseName(fileName);
    if (!database.open()) {
        QFile::remove(fileName);
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
    }

    if (QSqlDatabase::database().tables().contains(QStringLiteral("history"))) {
        // The table already exists; we don't need to do anything.
        qDebug()<<fileName;
        return;
    }
    //here I should write the core of the db

    QSqlQuery query;

    query.exec("PRAGMA foreign_keys = off;"
               "BEGIN TRANSACTION;");

    // Table: address
    query.exec("CREATE TABLE address (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL);");

    // Table: debtor
    query.exec("CREATE TABLE debtor (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL, surename VARCHAR, phone VARCHAR (7, 13), address REFERENCES address (id), e_mail VARCHAR, comment TEXT);");

    // Table: history
    query.exec("CREATE TABLE history (id INTEGER PRIMARY KEY AUTOINCREMENT, debtor REFERENCES debtor (id) NOT NULL, product VARCHAR NOT NULL, quantity INTEGER, cost DOUBLE NOT NULL, total_cost DOUBLE NOT NULL, comment_1 TEXT, borrowed_data DATETIME NOT NULL, lender REFERENCES lender (id) NOT NULL, paid_back DOUBLE, comment_2 TEXT, paid_back_to REFERENCES lender (id));");

    // Table: lender
    query.exec("CREATE TABLE lender (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL);");

    query.exec("COMMIT TRANSACTION;"
               "PRAGMA foreign_keys = on;");
}
#endif
