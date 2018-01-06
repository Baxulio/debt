import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

import sql.debtor.model 1.0

Page {
    id: debtorPage

    property int currentDebtor: -1

    header: DebtToolBar {
        Label {
            text: qsTr("Debtors")
            font.pixelSize: 20
            anchors.centerIn: parent
        }
        ToolButton {
            text: qsTr("Back")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            onClicked: debtorPage.StackView.view.pop()
        }
        ComboBox{
            id:filterColumnName
            model: ["Name", "Surename", "Phone"]
            currentIndex: 0
            onCurrentIndexChanged: {
                if(currentIndex===0)listView.model.sortBy("name")
                else if(currentIndex===1)listView.model.sortBy("surename");
                else listView.model.sortBy("phone");
            }
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

        }
    }
    ListView {
        id: listView
        anchors.fill: parent

        delegate: SwipeDelegate {
            id: delegate
            width: listView.width
            onClicked: {
                debtorPage.StackView.view.push("qrc:/ProductsPage.qml", { currentDebtor: model.id, currentDebtorName: model.name})
            }
            hoverEnabled: true
            onHoveredChanged: !hovered?checked=false:checked=true
            checkable: true
            contentItem: ColumnLayout{
                Row{
                Label {
                    text: name +" " + surename
                    font.bold: true
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
                Label{
                    text: "  ::  "+comment
                    font.italic: true
                    color: "grey"
                    elide: Text.ElideRight
                }
                }

                GridLayout {
                    id: grid
                    visible: false
                    columns: 2
                    rowSpacing: 10
                    columnSpacing: 10

                    Label {
                        text: qsTr("Address:")
                        Layout.leftMargin: 60
                    }

                    Label {
                        text: address_name_2
                        font.bold: true
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    Label {
                        text: qsTr("Phone:")
                        Layout.leftMargin: 60
                    }

                    Label {
                        text: phone
                        font.bold: true
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    Label {
                        text: qsTr("E_mail:")
                        Layout.leftMargin: 60
                    }

                    Label {
                        text: e_mail
                        font.bold: true
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
                states: [
                    State {
                        name: "expanded"
                        when: delegate.checked

                        PropertyChanges {
                            target: grid
                            visible: true
                        }
                    }
                ]
            }
            //Right
            swipe.right: Rectangle {
                color: SwipeDelegate.pressed ? "#333" : "#444"
                width: parent.width
                height: parent.height
                clip: true

                SwipeDelegate.onClicked: listModel.remove(index)

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
                    currentDebtor=index;
                    debtorDialog.editDebtor(listView.model.get(currentDebtor));
                }

                Label {
                    font.pixelSize: delegate.font.pixelSize
                    text: "Edit"
                    color: "white"
                    anchors.centerIn: parent
                }
            }
        }

        model: SqlDebtorModel {
            id: listModel
        }

        ScrollBar.vertical: ScrollBar { }

        section.property: {filterColumnName.currentIndex===0?"name":filterColumnName.currentIndex===1?"surename":"phone";}
        section.criteria: ViewSection.FirstCharacter
        section.delegate: sectionHeading
        section.labelPositioning: listView.section.labelPositioning |= ViewSection.CurrentLabelAtStart
    }
    Label {
        id: placeholder
        text: qsTr("No more Debtors")

        anchors.margins: 60
        anchors.fill: parent

        opacity: 0.5
        visible: listView.count === 0

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        wrapMode: Label.WordWrap
        font.pixelSize: 18
    }

    DebtorDialog {
        id: debtorDialog
        onFinished: {
            if (currentDebtor === -1)
                listView.model.append(name, surename, phone, email, comment, address)
            else
                listView.model.set(currentDebtor, name, surename, phone, email, comment, address)
        }
    }

    RoundButton {
        text: qsTr("+")
        highlighted: true
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            currentDebtor = -1
            debtorDialog.createDebtor()
        }
    }

//    footer: RowLayout {


//        //        TextArea {
//        //            id: messageField
//        //            Layout.fillWidth: true
//        //            placeholderText: qsTr("Search...")
//        //            wrapMode: TextArea.Wrap
//        //            onTextChanged: {
//        //                listView.currentIndex=20
//        //            }
//        //        }


//    }

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
}
