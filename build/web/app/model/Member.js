var modelMember = new Ext.regModel('Member',
		{
			idProperty: 'id',
			fields: [
				{ name: 'uyeNo', type: 'string' },
		        { name: 'firstName', type: 'string'},
		        { name: 'lastName', type: 'string'},
		        { name: 'kimlikNo', type: 'string'},
		        { name: 'paraBirimi', type: 'string'},
		        { name: 'dob', type: 'string'},
		        { name: 'ulke', type: 'string'},
		        { name: 'nickName', type: 'string'},
		        { name: 'cellPhone', type: 'string'},
		        { name: 'email', type: 'string'},
		        { name: 'address', type: 'string'},
		        { name: 'address2', type: 'string'},
		        { name: 'city', type: 'string'}
		    ]
		}
	);