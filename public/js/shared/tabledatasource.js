function TableDataSource(resourceUrl) {
	// fields
	var resourceUrl = resourceUrl;
	var isUpdating = false;

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
	this.get = function() {
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

	this.editRow = function($row) {
		resourceToShow.fields.forEach(function(field) {
			var name = field.name;
			$formInputs[name].val($("td." + name, $row).html());
		});

		idToUpdate = $row.attr("id");
		$divAdd.dialog("open");
	};

	this.onSuccess = function(data, action) {
		console.log('data updated from ' + resourceUrl + ' [action=' + action
				+ ']');
	};

	this.onError = function(xhr, textStatus, errorThrown) {
	};
}