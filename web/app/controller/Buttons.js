var memberActionBtn = new Ext.Button({
    id: 'memberActionButton',
    ui  : 'glass',
    text: 'Üye Bilgileri',
    handler: function(){
            panelMemberInfo.show('pop');
	}
});

var memberBetsBtn = new Ext.Button({
    id: 'memberBetsBtn',
    ui  : 'glass',
    text: 'Bahis Kuponları',
    handler: function(){
            panelMemberBets.show('pop');
	}
});

var memberAccountBtn = new Ext.Button({
    id: 'memberAccountBtn',
    ui  : 'glass',
    text: 'Hesap Hareketleri',
    handler: function(){
            panelMemberTransaction.show('pop');
	}
});