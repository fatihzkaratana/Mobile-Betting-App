var viewHome = new Ext.Container({
	fullscreen: true,
        layout: 'card',
        iconCls: 'home',
        id: 'viewHome',
        title: 'Ana Sayfa',
        scroll: 'vertical',
        items: [viewLoginForm],
        loadMask: true
});