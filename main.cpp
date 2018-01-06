#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <connection.h>
#include <sqldebtormodel.h>
#include <sqlhistorymodel.h>
#include <sqladdressmodel.h>
#include <productsmodel.h>
#include <sqllendermodel.h>

//#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("Debt");
    QCoreApplication::setOrganizationName("Bahman");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    createConnection();

    qmlRegisterType<SqlHistoryModel>("sql.history.model", 1, 0, "SqlHistoryModel");
    qmlRegisterType<SqlDebtorModel>("sql.debtor.model", 1, 0, "SqlDebtorModel");
    qmlRegisterType<SqlAddressModel>("sql.address.model", 1, 0, "SqlAddressModel");
    qmlRegisterType<SqlLenderModel>("sql.lender.model", 1, 0, "SqlLenderModel");
    qmlRegisterType<ProductsModel>("sql.products.model", 1, 0, "ProductsModel");

//    QQuickStyle::setStyle("Default");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
