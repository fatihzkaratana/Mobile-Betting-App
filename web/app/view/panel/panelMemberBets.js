var panelMemberBets = new Ext.Panel({
    floating: true,
    id: 'panelMemberBets',
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
            title: 'Üyelik Bilgileriniz'
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
                panelMemberBets.hide();
            }
        }],
    scroll: 'vertical',
    layout: 'auto'
});