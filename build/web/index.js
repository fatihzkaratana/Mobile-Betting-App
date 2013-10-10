Ext.ns('NicoBet','betListActions','couponActions','memberActions','navPanel', 'viewBetList');

Ext.setup({
    tabletStartupScreen: 'app/lib/images/tablet_startup.png',
    phoneStartupScreen: 'app/lib/images/Startup_320x460.png',
    icon: 'app/lib/images/icon.png',
    statusBarStyle: 'dark',
    glossOnIcon: true,
    fullscreen: true,
    useLoadMask: false,
    layout: 'card',
    onReady: function () {
        navPanel = new Ext.TabPanel({
                id: 'bodyView',
        	tabBar: {
		        dock: 'bottom',
		        ui: 'glass',
		        layout: {pack: 'center'}
		    },
		    cardSwitchAnimation: {
		        type: 'slide',
		        cover: true
		    },
        	layout: 'card',
                scroll: 'vertical',
        	fullscreen: true,
        	items:[viewHome]
        });
        navPanel.tabBar.hide();
    }
});