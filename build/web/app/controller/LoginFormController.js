var LoginFormController = new Ext.Controller({
	   submit: function(options) {
		      var form = options.data;
		      viewLoginForm.submit({
		         method: 'POST',
		         waitMsg: {
		            message: 'Kontrol ediliyor',
		            cls : 'demos-loading'
		         },
		         scope: this,
		         success: function(form) {
                                 navPanel.tabBar.show();
                                 addPanel(navPanel,viewBetList);
                                 navPanel.setActiveItem('viewBetList');
                                 addPanel(navPanel,viewMember);
                                 addPanel(navPanel,viewCoupon);
                                 removePanel(viewHome, viewLoginForm);
                                 addPanel(viewHome, panelLoggedIn);
                                 //removePanel(viewHome, toolbarLoginForm);
                                 //updatePanel(navPanel,viewMember);
                                 //updatePanel(navPanel,viewCoupon);
		         },
		         failure: function() {
		            notificationPanel.show('pop');
		         }
		      });
		   }
		});