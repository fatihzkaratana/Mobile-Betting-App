var viewBetList = new Ext.Panel({
    fullscreen: true,
    cls: 'panelCategory',
    id: 'viewBetList',
    modal: false,
    scroll: 'vertical',
    layout: 'card',
    iconCls: 'bookmarks',
    title: 'Bahis Listesi',
    dockedItems: [toolbarBetList],
    items: [panelCategory]
});