var viewLoginForm = new Ext.form.FormPanel({
    scroll: 'vertical',
    url   : 'http://' + serverURL + '/login.jsp',
    fullscreen: false,
    standardSubmit : false,
    id: 'viewLoginForm',
    frame:true,
    items: [{
        xtype: 'fieldset',
        title: 'Bahis oynamak için lütfen giriş yapınız.<p>&nbsp;</p>',
        //instructions: 'Bahis oynamak için lütfen giriş yapınız.<p><br /></p><img src="app/lib/images/canli_bahis.jpg" />',
        defaults: {
            labelAlign: 'left',
            labelWidth: '40%'
        },
        items: [
	        {
	            xtype: 'textfield',
	            name : 'username',
	            placeHolder: 'Kullanıcı adı',
	            useClearIcon: true,
	            autoCapitalize : false,
                    allowBlank:false,
                    id: 'nameField'
	        }, 
	        {
	            xtype: 'passwordfield',
	            name : 'password',
	            placeHolder: 'Şifre',
	            useClearIcon: true,
                    allowBlank:false,
                    id: 'passField'
	        },
                {
                    xtype: 'button',
                    name: 'btnLogin',
                    id: 'btnLogin',
                    handler: function() {
	          	Ext.dispatch({
	              	controller: LoginFormController,
	              	action: 'submit',
	              	data: viewLoginForm
	          		});
	          	},
                    text: 'Giriş'
                }
        ]
    }]
});