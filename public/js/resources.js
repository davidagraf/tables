/**
 * Resources configuration
 */
var globalResources = {
	computer : {
	  name : 'computer',
		title : 'Computers',
		fields : {
		  asset_tag : {
		    title : 'Asset Tag'
		  },
		  type : {
		    title : 'Type'
		  },
		  brand : {
		    title : 'Brand'
		  },
		  model : {
		    title : 'Model'
		  },
		  status : {
		    title : 'Status'
		  },
		  name : {
		    title : 'Name'
		  },
		  serial1 : {
		    title : 'Serial 1'
		  },
		  serial2 : {
		    title : 'Serial 2'
		  }
		} ,
		relations : {
		  software : {
		    title : 'Software'
		  }
		}
	},
	software : {
		name : 'software',
		title : 'Software',
		fields : {
		  name : {
		    title : 'Name'
		  },
		  version : {
		    title : 'Version',
		    type : 'version'
		  },
		  distributor : {
		    title : 'Distributor'
		  },
		  license : {
		    title : 'License'
		  },
		  expiration : {
		    title : 'Expiration Date',
		    type : 'date'
		  },
		  comments : {
		    title : 'Comments',
		    type : 'textarea'
		  }
		},
		relations : {
		  computer : {
		    title : 'Computers'
		  }
		}
	}
};