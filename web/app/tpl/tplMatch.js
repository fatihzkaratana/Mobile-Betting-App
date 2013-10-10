var tplMatch = new Ext.XTemplate(
        '<tpl for=".">',
                '<button id="betButton" class="inside" onClick="generatePanel(\'{matchId}\',\'Bet\', \'{matchName}\', 0, \'{gt}\')">\n',
                   '<div class="title"><span class="matchName">{matchName}</span><br/><span class="info">{matchDate} - Saat: {matchTime}</span>&nbsp;<span class="metadata">({gt})</span></div>',
                '</button>',
                '<br style="clear: both;" />',
        '</tpl>'
	);