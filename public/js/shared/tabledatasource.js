function TableDataSource(resourceUrl, resource) {
	// fields
	var isUpdating = false;
	this.resource = resource;

	TableAction = {
		GET : 'GET',
		ADD : 'ADD',
		UPDATE : 'UPDATE',
		DELETE : 'DELETE'
	};

	// public methods
	/**
	 * Gets the complete data from the server
	 */
	this.getRows = function() {
		var $this = this;
		$.ajax( {
			url : resourceUrl,
			dataType : 'json',
			success : function(data, textStatus, xhr) {
			  $this.onSuccess(data, TableAction.GET);
			},
			error : this.onError
		});
	};

	this.deleteRow = function($row) {
		var id = $row.attr("id");
		var $this = this;
		$.ajax( {
			type : "DELETE",
			url : "/" + resourceToShow.name + "/" + id,
			success : function(data, textStatus, xhr) {
			  $this.onSuccess($row, TableAction.DELETE);
			},
			error : this.onError
		});
	};

//	this.addRow = function(jsonToSend) {
//		var $this = this;
//		 $.ajax({
//		        type: "POST",
//		        url: url,
//		        data: $.toJSON(jsonToSend),
//		        contentType: "application/json; charset=utf-8",
//		        dataType: "json",
//		        success: function (data, textStatus, xhr) {
//			      $this.addOrReplaceRows((isReplace ? url : xhr.getResponseHeader("Location")), isReplace);
//		        },
//		        error: this.onError
//		      });
//	};
//	
//	this.updateRow = function(jsonToSend) {
//		 $this = this;
//		 $.ajax({
//			   type: "POST",
//		        url: url,
//		        data: $.toJSON(jsonToSend),
//		        contentType: "application/json; charset=utf-8",
//		        dataType: "json",
//		        success: function (data, textStatus, xhr) {
//			 $this.addOrReplaceRows((isReplace ? url : xhr.getResponseHeader("Location")), isReplace);
//		          $divAdd.dialog("close");
//		        },
//		        error: this.onError
//		      });
//	};

	this.onSuccess = function(data, action) {
		console.log('data updated from ' + resourceUrl + ' [action=' + action + ']');
	};

	this.onError = function(xhr, textStatus, errorThrown) {
	};
}