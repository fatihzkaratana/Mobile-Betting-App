var panelCategory = new Ext.DataView({
    cls: 'panelCategory',
    id: 'panelCategory',
    store: storeCategory,
    tpl: tplCategory,
    overItemCls:'x-list-item',
    itemSelector:'div.data',
    dockedItems: [
        {
        	dock: 'top',
        	xtype: 'toolbar',
        	title: 'Bahis Listesi'
        }
    ]
    //items: [dataviewCategory]
});
