/**
 * Initialization on document ready
 */
$(function() {
	// initialize code behind for current page
	var pageType = currentPageType();
	var view = createInstance(pageType);
	initializePageShared();
	
	// handle hash changed (while page context does not change!)
	$(window).bind(
			'hashchange',
			function() {
				newHash = window.location.hash.substring(1);
				view.clean();
				if (newHash) {
					var uri = parseUri(newHash);
					
					if (!view.init(uri)) {
						// something is wrong, do something
					}
				} 
			});

	$(window).trigger('hashchange');
	
	if(window.location.hash == '') {
		view.init(); // init without uri
	}
});