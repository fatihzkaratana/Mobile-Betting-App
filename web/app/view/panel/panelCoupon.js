var panelCoupon = new Ext.List({
    cls: 'panelCoupon',
    id: 'panelCoupon',
    store: storeCoupon,
    itemTpl: tplCoupon,
    grouped : true,
    emptyText: 'Henüz kupon oluşturmadınız.',
    overItemCls:'x-list-item',
    itemSelector:'div.data'
    //items: [dataviewCategory]
});
