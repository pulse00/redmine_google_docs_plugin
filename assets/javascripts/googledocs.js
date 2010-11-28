document.observe('dom:loaded', function() {
	
	$('issue_custom_field_values_1').up().up().insert('<div class="autocomplete" id="docs_candidates" style="display: none;"></div>');
	
	
	ac = new Ajax.Autocompleter('issue_custom_field_values_1',
	'docs_candidates',
	'/authsubs/listdocs',
	{ minChars: 3,
		frequency: 0.5,
		paramName: 'q',
		updateElement: function(value) {
		  
		  console.log(value);
      // setCurrentIssue(value.id, $(value).innerHTML);
      // $('issue_id').clear();
	}});		
	
});