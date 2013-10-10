var viewMember = new Ext.Panel({
    fullscreen: true,
    scroll: 'vertical',
    id: 'viewMember',
    cls: 'viewMember',
    style: 'text-align: center',
    layout: 'hbox',
    iconCls: 'user',
    title: 'Üye İşlemleri',
    dockedItems: [toolbarMemberView],
    items: [memberActionBtn, memberBetsBtn, memberAccountBtn]
});