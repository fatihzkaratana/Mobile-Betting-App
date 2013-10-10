var tplLeague = new Ext.XTemplate(
        '<tpl for=".">',
                '<button id="betButton" class="inside" onClick="generatePanel(\'{leagueId}\',\'Match\', \'{leagueName}\', 0, \'{match}\')">\n',
                   '<div class="title"><span class="league">{leagueName}</span>&nbsp;<span class="metadata">({match})</span></div>',
                '</button>',
                '<br style="clear: both;" />',
        '</tpl>'
	);