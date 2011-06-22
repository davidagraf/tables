/**
 * Resources configuration
 */
var globalResources = {
	computer : {
		name : 'computer',
		title : 'Computers',
		fields : [ {
			name : 'asset_tag',
			title : 'Asset Tag'
		}, {
			name : 'type',
			title : 'Type'
		}, {
			name : 'brand',
			title : 'Brand'
		}, {
			name : 'model',
			title : 'Model'
		}, {
			name : 'status',
			title : 'Status'
		}, {
			name : 'name',
			title : 'Name'
		}, {
			name : 'serial1',
			title : 'Serial 1'
		}, {
			name : 'serial2',
			title : 'Serial 2'
		} ],
		relations : [ {
			name : 'software',
			title : 'Software'
		} ]
	},
	software : {
		name : 'software',
		title : 'Software',
		fields : [ {
			name : 'name',
			title : 'Name'
		}, {
			name : 'version',
			title : 'Version',
			type : 'version'
		}, {
			name : 'distributor',
			title : 'Distributor'
		}, {
			name : 'license',
			title : 'License'
		}, {
			name : 'expiration',
			title : 'Expiration Date',
			type : 'date'
		}, {
			name : 'comments',
			title : 'Comments',
			type : 'textarea'
		} ],
		relations : [ {
			name : 'computer',
			title : 'Computers'
		} ]
	}
};