var panelMemberTransaction = new Ext.Panel({
    floating: true,
    id: 'panelMemberTransaction',
    cls: 'overlay', 
    modal: true,
    centered: true,
    autoWidth: true,
    store: userStore,
    dockedItems: [
        {
            dock: 'top',
            xtype: 'toolbar',
            ui: 'glass',
            title: 'Hesap Hareketleriniz'
        }
    ],
    items: [new Ext.DataView({
        store: userStore,
        tpl: tplMemberBet,
        autoHeight:true,
        multiSelect: false,
        overItemCls:'x-view-over',
        itemSelector:'div.thumb-wrap',
        emptyText: 'Üyelik bilgileri yüklenemedi!'
    }),
        {
            xtype: 'button',
            text: 'Tamam',
            ui: 'glass',
            id: 'myButton',
            cls: 'nicButton',
            handler: function(){
                panelMemberTransaction.hide();
            }
        }],
    scroll: 'vertical',
    layout: 'auto'
});