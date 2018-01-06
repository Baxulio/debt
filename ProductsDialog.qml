import QtQuick 2.7
import QtQuick.Controls 2.1
import sql.lender.model 1.0

Dialog {
    id: dialog
    //Component.onCompleted: preset()

    signal finished(string product, double quantity, double cost, string comment_1, string borrowed_data, int lender, double paid_back, string paid_back_data, string comment_2, int paid_back_to)

    function createDebt(pay) {

        if(pay){
            makeInvisible(true);
            dialog.title = qsTr("Pay Debt");
        }
        else {
            makeInvisible(false)
            dialog.title = qsTr("Add Debt");
        }

        dialog.open();
    }

    function editDebt(debt) {
        form.product.text=debt.product;
        form.quantity.value=debt.quantity;
        form.cost.value=debt.cost;
        form.comment_1.text=debt.comment_1;
        form.borrowed_data.text=debt.borrowed_data;
        form.lender.currentIndex=debt.lender;

        if(debt.paid_back=="")makeInvisible(false)
        else{
            form.paid_back.value=debt.paid_back;
            form.paid_back_data.text=debt.paid_back_data;
            form.comment_2.text=debt.comment_2;
            form.paid_back_to.currentIndex=debt.paid_back_to;
        }

        dialog.title = qsTr("Edit Debt");
        dialog.open();
    }
    function preset()
    {
        if(!form.product.visible)
        {
            form.product.visible=true;
            form.quantity.visible=true;
            form.cost.visible=true;
            form.comment_1.visible=true;
            form.borrowed_data.visible=true;
            form.lender.visible=true;
        }
        if(!form.paid_back.visible)
        {
            form.paid_back.visible=true;
            form.paid_back_data.visible=true;
            form.comment_2.visible=true;
            form.paid_back_to.visible=true;
        }
        if(form.product!="")
        {
            form.product.clear();
            form.quantity.value=0;
            form.cost.value=0;
            form.comment_1.clear();
            form.borrowed_data.clear();
            form.lender.currentIndex=-1;
        }
        if(form.paid_back.value!=0)
        {
            form.paid_back.value=0;
            form.paid_back_data.clear();
            form.comment_2.clear();
            form.paid_back_to.currentIndex=-1;
        }

    }
    function makeInvisible(part)
    {
        if(part)
        {
            form.product.visible=false;
            form.quantity.visible=false;
            form.cost.visible=false;
            form.comment_1.visible=false;
            form.borrowed_data.visible=false;
            form.lender.visible=false;
            return;
        }
        form.paid_back.visible=false;
        form.paid_back_data.visible=false;
        form.comment_2.visible=false;
        form.paid_back_to.visible=false;
    }

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    focus: true
    modal: true
    //title: qsTr("Add Debt")
    standardButtons: Dialog.Ok | Dialog.Cancel

    SqlLenderModel{
        id:model;
    }
    contentItem: ProductsForm {
        id: form
        lender.model: model
        paid_back_to.model: model
    }
    onAccepted: finished(form.product.text,
                         form.quantity.value,
                         form.cost.value,
                         form.comment_1.text,
                         form.borrowed_data,
                         form.lender.currentIndex,
                         form.paid_back.value,
                         form.paid_back_data.text,
                         form.comment_2.text,
                         form.paid_back_to.currentIndex)
}
