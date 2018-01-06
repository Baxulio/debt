import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

GridLayout {
    id: grid
    property alias name: name
    property alias surename: surename
    property alias phone: phone
    property alias email: email
    property alias address: address
    property alias comment: comment

    property int minimumInputSize: 120
    property string placeholderText: qsTr("<enter>")

    rows: 6
    columns: 2

    ListView{}
    Label {
        text: qsTr("Name")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: name
        focus: true
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("Surename")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }


    TextField {
        id: surename
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("Phone")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: phone
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("E_mail")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextField {
        id: email
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("Address")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    ComboBox {
        id: address
        textRole: "display"
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    Label {
        text: qsTr("Comment")
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
    }

    TextArea {
        id: comment
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }
}
