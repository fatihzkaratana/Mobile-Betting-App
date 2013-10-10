var tplCoupon = new Ext.XTemplate(
        '<tpl for=".">',
        '<button class="inside" id="betButton" onClick="removeCoupon(\'{matchId}\',\'{matchName}\', \'{betName}\', {betRate}, 0)">',
                '<div id="couponTitle">{betName} - {betRate}</div>',
                '</button>',
        '</tpl>'
	);