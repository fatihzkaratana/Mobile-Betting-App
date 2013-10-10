var viewCoupon = new Ext.Panel({
            fullscreen: true,
            cls: 'viewCoupon',
            id: 'viewCoupon',
            modal: false,
            scroll: 'vertical',
            layout: 'card',
            iconCls: 'add',
            title: 'Kupon',
            dockedItems: [
                    {
                        xtype: 'toolbar',
                        title: 'Kuponlarınız',
                        items: [couponBack],
                        ui: 'glass'
                    },
                    {
                        xtype: 'toolbar',
                        dock: 'bottom',
                        layout: { pack: 'center'},
                        id: 'couponToolbar',
                        cls: 'bottom',
                        ui: 'none',
                        items: [
                            {
                                xtype: 'button',
                                text: 'Gönder',
                                ui: 'glass',
                                cls: 'nicButton',
                                handler: function(){
                                    sendCouponList(storeCoupon);
                                }
                            }
                        ]
                    }
            ],
            items: [panelCoupon]
        });