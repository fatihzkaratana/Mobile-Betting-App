var serverURL = "10.1.0.104:8084/mobile/jsp/";
var btnBack = new Ext.Button({
            text: '',
            id: 'btnBack',
            ui: 'glass',
            hidden: true
        });
var couponBack = new Ext.Button({
    text: '',
    id: 'couponBack',
    ui: 'glass',
    hidden: true,
    handler: function(){
            if ( storeCoupon.getCount() > 0 ){
            navPanel.setActiveItem('viewBetList', {type: 'slide', direction: 'right'});
            }
    }
});
var backStack = new Array();
var titleStack = new Array();
var panelCls = new Array();
var notificationItem = "Girdiğiniz bilgiler sistemde kayıtlı bilgileriniz ile doğrulanmadı.<br /> Lütfen tekrar deneyiniz.";
var notificationTitle = "Üzgünüz";
var notificationPanel = new Ext.Panel({
        floating: true,
        id: 'notificationPanel',
        cls: 'notificationPanel',
        modal: true,
        centered: true,
        autoWidth: false,
        defaults: 'width: 80%; text-align: center;',
        dockedItems: [
            {
                    dock: 'top',
                    xtype: 'toolbar',
                    ui: 'glass',
                    title: notificationTitle
            },
            {
                dock: 'bottom',
                xtype: 'toolbar',
                layout: {
                            pack: 'center'
                        },
                items: 
                        [
                            {
                                xtype: 'button',
                                text: 'Tekrar dene',
                                handler: function(){
                                        notificationPanel.hide();
                                },
                                ui  : 'confirm'
                            }
                        ]
            }
        ],
        html: notificationItem
    });