function handleFeed(response) {
	
  var entries = response.feed.entry;
  
  if (!entries.length) {

		alert('no documents found');
    return;
  }
  
  var html = [];
  
  for (var i = 0, entry; entry = entries[i]; i++) {
    var title = entry.title.$t;

		$('docs').insert('<li rel="' + entry.link[0].href + '">' + title + '</li>')
  }
  
	console.log(response);	
	
}


function handleError(e) {
	
	
	
}

document.observe('dom:loaded', function() {
	
	var email = $('gdocs_email').readAttribute('rel');

	if (email.length == 0)
		return;
		
		
	$('issue_custom_field_values_1').observe('click', function() {
		
	
		try {
			Modalbox.show('<div><ul id="docs"></ul></div>', {
	      doNotMove: true,
	      title: 'Search your Google Docs',
	      overlayDuration: 0.0,
	      slideDownDuration: 0.0,
	      slideUpDuration: 0.0,
	      resizeDuration: 0.0,
	      overlayOpacity: 0.01,
	      autoFocusing: false,
				afterLoad: function(){


					var scope = 'https://docs.google.com/feeds/';
					start = new Date().getTime();    
					if (google.accounts.user.checkLogin(scope)) {   
						var service = new google.gdata.client.GoogleService('writely', 'DocList-App-v2.0'); 
						service.getFeed(scope + 'documents/private/full/', handleFeed, handleError);
					} else {
						var token = google.accounts.user.login(scope); // can ignore returned token
					}    

					console.log('test');

				}

			});
		} catch (e) {
			
			console.log(e);
			
		}
		
	});

	
	
});