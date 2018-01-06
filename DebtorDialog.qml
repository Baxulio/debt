import QtQuick 2.7
import QtQuick.Controls 2.1
import sql.address.model 1.0

Dialog {
    id: dialog

    signal finished(string name, string surename, string phone, string email, string comment, int address)

    function createDebtor() {
        form.name.clear();
        form.surename.clear();
        form.phone.clear();
        form.email.clear();
        form.comment.clear();
        form.address.currentIndex=-1;

        dialog.title = qsTr("Add Debtor");
        dialog.open();
    }

    function editDebtor(debtor) {
        form.name.text = debtor.name;
        form.surename.text = debtor.surename;
        form.phone.text = debtor.phone;
        form.email.text = debtor.email;
        form.comment.text = debtor.comment;
        form.address.currentIndex = debtor.address;

        dialog.title = qsTr("Edit Debtor");
        dialog.open();
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    title: qsTr("Add Debtor")
    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: DebtorForm {
        id: form
        address.model: SqlAddressModel{}
    }
    onAccepted: finished(form.name.text, form.surename.text, form.phone.text, form.email.text, form.comment.text, form.address.currentIndex)
}
