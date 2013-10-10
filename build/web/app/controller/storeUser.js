var userStore = new Ext.data.Store({
    model: 'Member',
    proxy: {
        type: 'ajax',
        url : 'http://' + serverURL + 'User.json',
        reader: {
            type: 'json',
            root: 'user'
        }
    },
    autoLoad: true
});