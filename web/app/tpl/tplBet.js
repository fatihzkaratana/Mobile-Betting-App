var tplBet = new Ext.XTemplate(
            '<tpl for=".">',
                   '<tpl if="betName1 != 0 && betRate1 != 0" >',
                        '<button class="inside" id="betButton" onClick="createCoupon(\'{matchId}\',\'{matchName}\', \'{betName1}\', {betRate1}, 0)">',
                            '<div id="betTitle">{betName1}-{betRate1}</div>',
                        '</button>',
                    '</tpl>',
                    '<tpl if="betName2 != 0 && betRate2 != 0" >',
                        '<button class="inside" id="betButton" onClick="createCoupon(\'{matchId}\',\'{matchName}\', \'{betName2}\', {betRate2}, 0)">',
                            '<div id="betTitle">{betName2}-{betRate2}</div>',
                        '</button>',
                    '</tpl>',
                    '<tpl if="betName3 != 0 && betRate3 != 0" >',
                        '<button class="inside" id="betButton" onClick="createCoupon(\'{matchId}\',\'{matchName}\', \'{betName3}\', {betRate3}, 0)">',
                            '<div id="betTitle">{betName3}-{betRate3}</div>',
                        '</button>',
                    '</tpl>',
            '</tpl>'
	);