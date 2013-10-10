var panelMemberInfo = new Ext.Panel({
    floating: true,
    id: 'panelMemberInfo',
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
        tpl: tplMemberInfo,
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
                panelMemberInfo.hide();
            }
        }],
    scroll: 'vertical',
    layout: 'auto'
});