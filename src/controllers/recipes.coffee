db = require '../database'

module.exports =
	list: (req, res) ->
		db.Recipe.find {}, (err, data) ->

			res.render 'recipes/list',
				recipes: data

	#lookup recipe by id and save it for  alter part of the request
	lookup: (req, res, next, id) -> 
		if id == 'sample'
			req.recipe =
				name: 'Sample Recipe'
				author: 'Donald Mull Jr.'
				tags: [ 'tasty', 'do-not-eat' ]
				links: [
					{ type: 'parent', name: 'Some old recipe', author: 'Cavemen', uri: '/recipes/1' }
					{ type: 'related', name: 'Ricin', author: 'Walter White', uri: '/recipes/2' }
				]
				ingredients: [
					{ volume: '1 TBSP', ingredient: 'Cyanide' }
					{ weight: '4 grams', ingredient: 'Arsenic' }
				]
				instructions: [
					'mix arsenic and cyanide'
					'give to enemies'
				]
			next()
			return

		db.Recipe.findById id, (err, recipe) ->
			if err
				next err
			else
				req.recipe = recipe
				next()

	# render view with the recipe that was found
	details: (req, res) ->
		res.render 'recipes/details', { recipe: req.recipe }

	create: (req, res) ->
		res.render 'recipes/create'

	save: (req, res, next) ->
		recipe = new db.Recipe(req.body)

		recipe.save (err, data) ->
			if err
				next(err)

			if req.xhr #ajax
				res.json data
			else
				res.redirect '/recipes'
