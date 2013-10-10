var storeCategory = new Ext.data.Store({
    model: 'Category',
    proxy: {
        type: 'ajax',
        url : 'http://' + serverURL + '/select.jsp?model=1',
        reader: {
            type: 'json',
            root: 'items'
        }
    },
    autoLoad: true
});