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
		if (isUpdating)
			return;
		isUpdating = true;
		$.ajax( {
			url : resourceUrl,
			dataType : 'json',
			success : function(data, textStatus, xHr) {
				this.onSuccess(data, TableAction.GET);
				isUpdating = false;
			},
			error : onError
		});
	};

	this.deleteRow = function($row) {
		var id = $row.attr("id");
		$.ajax( {
			type : "DELETE",
			url : "/" + resourceToShow.name + "/" + id,
			success : function(data, textStatus, xhr) {
				this.onSuccess($row, TableAction.DELETE);
			},
			error : onError
		});
	};

	this.addRow = function(jsonToSend) {
		 $.ajax({
		        type: "POST",
		        url: url,
		        data: $.toJSON(jsonToSend),
		        contentType: "application/json; charset=utf-8",
		        dataType: "json",
		        success: function (data, textStatus, xhr) {
		          addOrReplaceRows((isReplace ? url : xhr.getResponseHeader("Location")), isReplace);
		          
		        },
		        error: onError
		      });
	};
	
	this.updateRow = function(jsonToSend) {
		 $.ajax({
			   type: "POST",
		        url: url,
		        data: $.toJSON(jsonToSend),
		        contentType: "application/json; charset=utf-8",
		        dataType: "json",
		        success: function (data, textStatus, xhr) {
		          addOrReplaceRows((isReplace ? url : xhr.getResponseHeader("Location")), isReplace);
		          $divAdd.dialog("close");
		        },
		        error: function (xhr, textStatus, errorThrown) {
		          showFormError(xhr.status + " " + errorThrown);
		        }
		      });
	};

	this.onSuccess = function(data, action) {
		console.log('data updated from ' + resourceUrl + ' [action=' + action
				+ ']');
	};

	this.onError = function(xhr, textStatus, errorThrown) {
	};
}