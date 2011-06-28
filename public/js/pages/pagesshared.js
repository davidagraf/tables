/**
 * Initializes the shared functionality used for all pages
 */
function initializePageShared() {
	var contentMinHeight = document.defaultView.innerHeight - 200;
	
	$('#div-content').css('min-height', contentMinHeight + 'px');
}