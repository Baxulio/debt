import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtQml 2.2

import sql.products.model 1.0

Page {
    id: productPage

    property variant currentDebtor: -1
    property string currentDebtorName
    property int currentDebt:-1
    property bool pay

    header: DebtToolBar {
        Label {
            text: currentDebtorName
            font.pixelSize: 20
            anchors.centerIn: parent
        }
        ToolButton {
            text: qsTr("Back")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: productPage.StackView.view.pop()
        }
    }
    //Section Component
    Component {
        id: sectionHeading
        ToolBar {
            opacity: 0.8
            width: listView.width
            Label {
                id: label
                text: section
                anchors.fill: parent
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }
        }
    }
    ListView {
        id: listView
        anchors.fill: parent

        delegate: SwipeDelegate {
            id: delegate
            width: listView.width
            onClicked: {
                currentDebt=id;
                pay=true;
                dialog.preset();
                dialog.createDebt(true);
            }

            property double debt: quantity*cost-paid_back
            contentItem: ColumnLayout{
                Label{
                    text: borrowed_time+ "  ::  " + lender_name
                    font.italic: true
                    color: "grey"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                RowLayout{
                    Layout.fillWidth: true

                    ColumnLayout{
                        Layout.fillWidth: true

                        RowLayout {
                            id: rowLayout
                            Layout.fillWidth: true

                            Label {
                                text: product
                                font.bold: true
                                elide: Text.ElideRight
                            }

                            Rectangle{
                                color: "yellow"
                                Text {
                                    id: rectId
                                    text: quantity + " units"
                                    anchors.centerIn: parent
                                }
                                height: rectId.implicitHeight+5
                                width:  rectId.implicitWidth+5
                                radius: 2
                            }
                            Image {
                                id: money
                                source: "qrc:/images/money2.png"
                                sourceSize.width: 20
                                sourceSize.height: 20
                            }
                            Label{
                                text: cost
                            }
                            Label {
                                text: "  ::  "+comment_1
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                                font.italic: true
                                color: "grey"
                            }
                        }
                        Label{
                            visible: paid_back!=""
                            text: paid_back_data
                            font.italic: true
                            color: "grey"
                            elide: Text.ElideRight
                        }
                        RowLayout{
                            Layout.fillWidth: true
                            visible: paid_back!=""
                            Label{
                                text: "Was returned "
                                font.italic: true
                                elide: Text.ElideRight
                            }
                            Rectangle {
                                color: "#5fba7d"

                                Text {
                                    id: paidText
                                    text: "+ " + paid_back
                                    anchors.centerIn: parent
                                    color: "white"
                                }
                                height: paidText.implicitHeight+5
                                width:  paidText.implicitWidth+5
                                radius: 3
                            }
                            Label{
                                text: " to "+paid_back_to_name
                                font.italic: true
                                elide: Text.ElideRight
                            }
                            Label {
                                text: "  ::  "+comment_2
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                                font.italic: true
                                color: "grey"
                            }

                        }
                    }

                    Rectangle {
                        color: debt!=0?"red":"#5fba7d"

                        Text {
                            id: totalDebt
                            text: debt===0?"Sunk":"-" + debt
                            anchors.centerIn: parent
                            color: "white"
                            font.pointSize: 12
                        }
                        height: totalDebt.implicitHeight+10
                        width:  totalDebt.implicitWidth+10
                        radius: 3
                    }
                }
            }
            //Right
            swipe.right: Rectangle {
                color: SwipeDelegate.pressed ? "#333" : "#444"
                width: parent.width
                height: parent.height
                clip: true

                SwipeDelegate.onClicked: listModel.remove(model.id)

                Label {
                    font.pixelSize: delegate.font.pixelSize
                    text: "Remove"
                    color: "white"
                    anchors.centerIn: parent
                }

            }
            //Left
            swipe.left: Rectangle {
                color: SwipeDelegate.pressed ? "#333" : "#444"
                width: parent.width
                height: parent.height
                clip: true

                SwipeDelegate.onClicked: {
                    currentDebt=id;
                    pay=false;
                    dialog.preset();
                    dialog.editDebt(listView.model.get(index));
                }

                Label {
                    font.pixelSize: delegate.font.pixelSize
                    text: "Edit"
                    color: "white"
                    anchors.centerIn: parent
                }
            }
        }

        model: ProductsModel {
            id: listModel
            curDebtor: currentDebtor
        }

        ScrollBar.vertical: ScrollBar { }

        section.property: "borrowed_data"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading
        section.labelPositioning: listView.section.labelPositioning |= ViewSection.CurrentLabelAtStart
    }
    Label {
        id: placeholder
        text: qsTr("No Debts")

        anchors.margins: 60
        anchors.fill: parent

        opacity: 0.5
        visible: listView.count === 0

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        wrapMode: Label.WordWrap
        font.pixelSize: 18
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            currentDebt=-1;
            dialog.preset();
            dialog.createDebt(false);
        }
    }

    ProductsDialog{
        id: dialog
        onFinished: {
            if (currentDebt === -1)
                listView.model.set(true,currentDebt,currentDebtor,product,quantity,cost, comment_1,borrowed_data,lender,paid_back,paid_back_data,comment_2,paid_back_to) //append
            else
                listView.model.set(false, currentDebt,currentDebtor, product,quantity,cost, comment_1,borrowed_data,lender,paid_back,paid_back_data,comment_2,paid_back_to) //pay and edit
        }
    }
}
