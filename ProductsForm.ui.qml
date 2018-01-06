import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

GridLayout {
    id: grid
    property alias product: product
    property alias quantity: quantity
    property alias cost: cost
    property alias comment_1: comment_1
    property alias borrowed_data: borrowed_data
    property alias lender: lender

    property alias paid_back: paid_back
    property alias paid_back_data: paid_back_data
    property alias comment_2: comment_2
    property alias paid_back_to: paid_back_to

    property int minimumInputSize: 120
    property string placeholderText: qsTr("<enter>")

    rows: 10
    columns: 2

    Label {
        text: qsTr("Product")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: product.visible
    }

    TextField {
        id: product
        focus: true
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("Quantity")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: quantity.visible
    }
    SpinBox {
        id: quantity
        stepSize: 1
        to: 1000000
        focus: true
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Price")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: cost.visible
    }

    SpinBox {
        id: cost
        stepSize: 50
        to: 1000000
        focus: true
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Comment")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: comment_1.visible
    }

    TextField {
        id: comment_1
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("Data")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: borrowed_data.visible
    }

    RowLayout {
        visible: borrowed_data.visible
        //Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        Layout.fillWidth: true
        TextEdit {
            id: borrowed_data
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            //placeholderText: grid.placeholderText
        }
        Button {
            id: borrowed_data_but
            text: "Today"
        }
    }

    Label {
        text: qsTr("Lender")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: lender.visible
    }

    ComboBox {
        id: lender
        textRole: "display"
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }
    Label {
        text: qsTr("Paid back")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: paid_back.visible
    }

    SpinBox {
        id: paid_back
        stepSize: 50
        to: 1000000
        focus: true
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }
    Label {
        text: qsTr("Data")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: paid_back_data.visible
    }

    RowLayout {
        visible: paid_back_data.visible
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        Layout.fillWidth: true
        TextEdit {
            id: paid_back_data
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: grid.minimumInputSize
            //placeholderText: grid.placeholderText
        }
        Button {
            id: paid_back_data_but
            text: "Today"
        }
    }
    Label {
        text: qsTr("Comment")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: comment_2.visible
    }

    TextField {
        id: comment_2
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }
    Label {
        text: qsTr("Debt reciever")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        visible: paid_back_to.visible
    }

    ComboBox {
        id: paid_back_to
        textRole: "display"
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }
}
