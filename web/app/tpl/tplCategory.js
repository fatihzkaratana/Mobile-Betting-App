var tplCategory = new Ext.XTemplate(
        '<tpl for=".">',
                '<button id="betButton" class="{catName}" onClick="generatePanel(\'{catId}\',\'League\', \'{catName}\', 0, \'{lig}\')">\n',
                   '<div class="shape"></div><div class="title">{catName}</div>',
                '</button>',
        '</tpl>'
	);