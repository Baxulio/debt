import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import sql.history.model 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Debt")

    SqlHistoryModel {
                id: sqlHistoryModel
            }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: Page {
            id: historyPage

            header: DebtToolBar {
                Label {
                    text: qsTr("Latest Activity")
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                ToolButton {
                    text: qsTr("Debtors")
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: stackView.push("qrc:/DebtorPage.qml",{})
                }
            }

            ListView {
                id: listView
                anchors.fill: parent
                topMargin: 48
                leftMargin: 48
                bottomMargin: 48
                rightMargin: 48
                spacing: 20
                model: sqlHistoryModel
                delegate: Text {
                    id: name
                    text: id
                }
            }
        }
    }
}
