var toolbarHomePage = new Ext.Toolbar({
    id: 'homepageToolbar',
    title: 'Nicosia Betting',
    dock: 'top'
});

var toolbarLoginForm = new Ext.Toolbar({
    id: 'toolbarLoginForm',
    dock: 'bottom',
    items: [
                  {
                        text: 'Sil',
                        handler: function() {
                                viewLoginForm.reset();
                        }
                  },
              {xtype: 'spacer'},
              {
                  text: 'Giriş Yap',
                  ui: 'confirm',
                  id: 'btnLogin',
                  handler: function() {
                        Ext.dispatch({
                        controller: LoginFormController,
                        action: 'submit',
                        data: viewLoginForm
                                });
                        }
              }
          ]
        });

var toolbarMemberView = new Ext.Toolbar({
    id: 'memberlistToolbar',
    title: 'Üye İşlemleri',
    ui: 'glass',
    dock: 'top'
});

var toolbarBetList = new Ext.Toolbar({
    id: 'toolbarBetList',
    title: 'Bahis Listesi',
    ui: 'glass',
    dock: 'top',
    items: [btnBack,{xtype: 'spacer', baseCls: 'nicoLogo'}]
});
