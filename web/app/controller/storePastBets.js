var userBets = new Ext.data.Store({
    model: 'PastBets',
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