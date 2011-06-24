function TableDataSource(resourceUrl, resource) {
	// fields
	var $this = $(this);
	var isUpdating = false;
	this.resource = resource;
	EVENT_ON_SUCCESS = "onsuccess";
	EVENT_ON_ERROR = "onerror";

	TableAction = {
		GET : 'GET',
		ADD : 'ADD',
		UPDATE : 'UPDATE',
		DELETE : 'DELETE'
	};

	// private methods
	function getRowData(rowUrl, tableaction) {
		$.ajax( {
			url : rowUrl,
			dataType : 'json',
			success : function(data, textStatus, xhr) {
				onSuccess(data, tableaction);
			},
			error : this.onError
		});
	}

	function getRowUrl(rowId) {
		return '/' + resource.name + (rowId ? '/' + rowId : '');
	}
	
	function getRelationUrl(rowId, targetResource, targetRowId) {
	  return '/' + resource.name + '/' + rowId + '/' + targetResource.name + '/' + targetRowId;
	}
	
	function onSuccess(data, action) {
		console.log('TableDataSource: data updated for "' + resource.name + '" [action=' + action + ']');
		$this.trigger(EVENT_ON_SUCCESS, [data, action]);
	}

	function onError(xhr, textStatus, errorThrown) {
		console.log('TableDataSource: error on data update for "' + resource.name + '" [action=' + action + ']');
		console.log('ERROR: ' + textStatus);
		$this.trigger(EVENT_ON_ERROR, [xhr, textStatus, errorThrown]);
	}

	// public methods
	/**
	 * Gets the complete data from the server
	 */
	this.getRows = function() {
		this.getRowsByUrl(resourceUrl);
	};
	
	this.getRowsByUrl = function(passedResourceUrl) {
	  $.ajax( {
      url : passedResourceUrl,
      dataType : 'json',
      success : function(data, textStatus, xhr) {
        onSuccess(data, TableAction.GET);
      },
      error : onError
    });
	};

	this.deleteRow = function(rowId) {
		$.ajax( {
			type : "DELETE",
			url : getRowUrl(rowId),
			success : function(data, textStatus, xhr) {
				onSuccess(rowId, TableAction.DELETE);
			},
			error : onError
		});
	};

	this.addRow = function(rowData) {
		$.ajax( {
			type : "POST",
			url : getRowUrl(),
			data : $.toJSON(rowData),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data, textStatus, xhr) {
				getRowData(xhr.getResponseHeader("Location"), TableAction.ADD);
			},
			error : onError
		});
	};

	/**
	 * Updates the row with the given id
	 *  @param rowId : row to be updated
	 *  @param rowData: data
	 */
	this.updateRow = function(rowId, rowData) {
		$.ajax( {
			type : "POST",
			url : getRowUrl(rowId),
			data : $.toJSON(rowData),
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(data, textStatus, xhr) {
				getRowData(getRowUrl(rowId), TableAction.UPDATE);
			},
			error : onError
		});
	};
	
	/**
	 * Adds a relation source->target to a relation table.
	 * @param sourceId : id of source (resource of the source is saved in this object) 
	 * @param targetResource : resource of the target
	 * @param targetId : id of the target
	 */
	this.addRelation = function(sourceId, targetResource, targetId) {
	  $.ajax( {
	    type : "POST",
	    url : getRelationUrl(sourceId, targetResource, targetId),
	    success : function(data, textStatus, xhr) {
	      onSuccess(sourceId, TableAction.DELETE);
	    },
	    error : onError
	  });
	};
	
	/**
   * Removes a relation source->target from a relation table.
   * @param sourceId : id of source (resource of the source is saved in this object) 
   * @param targetResource : resource of the target
   * @param targetId : id of the target
   */
	this.removeRelation = function(sourceId, targetResource, targetId) {
	   $.ajax( {
	      type : "DELETE",
	      url : getRelationUrl(sourceId, targetResource, targetId),
	      success : function(data, textStatus, xhr) {
	        onSuccess(sourceId, TableAction.DELETE);
	      },
	      error : onError
	    });
	};

	/**
	 * Registers the given handler for the onSuccess event
	 */
	this.registerOnSuccess = function(handler) {
		$(this).bind(EVENT_ON_SUCCESS, handler);
	};
	
	/**
	 * Registers the given handler for the onError event
	 */
	this.registerOnError = function(handler) {
		$(this).bind(EVENT_ON_ERROR, handler);
	};
}