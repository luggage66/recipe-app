ViewModel = () ->
	@editing = ko.observable null

	@commit = {

	};

	@edit = () =>
		@editing {}

	@getData = (keys) =>
		if keys.ref
			url = '/api/recipes/ref/' + keys.ref
			deferred = $.getJSON(url).done (data) =>
					@commit = data
			return deferred
		
	return this

$ ->
	window.viewModel = new ViewModel