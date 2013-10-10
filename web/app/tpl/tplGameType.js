var tplGameType = new Ext.XTemplate(
        '<tpl for=".">',
                '<button id="betButton" onClick="generatePanel(\'{gtId}\',\'Bet\', \'{gtName}\', {matchId}, 0)">\n',
                   '<div class="title">{gtName}</div><div class="metadata">(+8)</div>',
                '</button>',
                '<br style="clear: both;" />',
        '</tpl>'
	);