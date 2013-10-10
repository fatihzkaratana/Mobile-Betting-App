var storeCoupon = new Ext.data.Store({
    model: 'Coupon',
    groupField: 'matchName',
    autoLoad: true,
        proxy: {
            type: 'localstorage',
            id  : 'nb-mobil-coupon'
        }
});