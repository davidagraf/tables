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

	// private methods
	function getRowData(rowUrl, tableaction) {
		var $this = this;
		$.ajax( {
			url : rowUrl,
			dataType : 'json',
			success : function(data, textStatus, xhr) {
				$this.onSuccess(data, tableaction);
			},
			error : this.onError
		});
	}

	function getRowUrl(rowId) {
		return '/' + resource.name + (rowId ? '/' + rowId : '');
	}

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

	this.deleteRow = function(rowId) {
		var $this = this;
		$.ajax( {
			type : "DELETE",
			url : getRowUrl(rowId),
			success : function(data, textStatus, xhr) {
				$this.onSuccess(rowId, TableAction.DELETE);
			},
			error : this.onError
		});
	};

	this.addRow = function(rowData) {
		var $this = this;
		$.ajax( {
			type : "POST",
			url : getRowUrl(),
			data : $.toJSON(rowData),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data, textStatus, xhr) {
				getRowData(xhr.getResponseHeader("Location"), TableAction.ADD);
			},
			error : this.onError
		});
	};

	this.updateRow = function(rowId, rowData) {
		$this = this;
		$.ajax( {
			type : "POST",
			url : getRowUrl(rowId),
			data : $.toJSON(rowData),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data, textStatus, xhr) {
				getRowData(getRowUrl(rowId), TableAction.UPDATE);
			},
			error : this.onError
		});
	};

	this.onSuccess = function(data, action) {
		console.log('data updated from ' + resourceUrl + ' [action=' + action
				+ ']');
	};

	this.onError = function(xhr, textStatus, errorThrown) {
	};
}