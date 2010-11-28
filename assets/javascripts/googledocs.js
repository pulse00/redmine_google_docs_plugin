document.observe('dom:loaded', function() {
	
	$$('input.gdocs_input').each(function(element) {
		
		var id = element.identify();
		var container = id + '_candidates';
		
		element.up().up().insert('<div class="autocomplete" id="' + container + '" style="display: none;"></div>');	
		
		new Ajax.Autocompleter(id,
		container,
		'/authsubs/listdocs',
		{ minChars: 3,
			frequency: 0.5,
			paramName: 'q',
			updateElement: function(value) {
				
				if (value.id == 'notconnected') {
					return;
				}
				
				var text = '"' + value.innerHTML + '":' + value.id;
				element.value = text;
		}});		
	});
});