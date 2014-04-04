db = require '../database'
async = require 'async'

getRefs = (done) ->
	db.RecipeRef.find {}, (err, refs) ->
		if err
			done err
		else
			done null, refs

getRef = (id, done) ->
	db.RecipeRef.findById id, done

getCommit = (commitId, done) ->
	async.waterfall [
			(done) ->
				db.RecipeCommit.findById commitId, done
			(commit, done) ->
				db.RecipeCommit.populate commit, [{path: 'data'}], done
		], done

module.exports =
	list: (req, res) ->
		getRefs (err, data) ->
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

		getCommit id, (err, result) ->
			req.recipe = result
			next()

	lookupUser: (req, res, next, id) -> 
		next()

	lookupRef: (req, res, next, id) -> 
		req.refId = id;
		next();

	create: (req, res) ->
		res.render 'recipes/create'

	save: (req, res, next) ->
		async.waterfall [
				(done) ->
					data = new db.RecipeData(req.body)
					data.save done
				(data, rows, done) ->
					recipeCommit = new db.RecipeCommit
						parents: []
						data: data.id
						author: 'dmull'
					recipeCommit.save done
				(data, rows, done) ->
					recipeRef = new db.RecipeRef
						name: req.body.name
						head: data.id
					recipeRef.save done
			], (err, result) ->
				if err
					next(err)
				else
					res.redirect '/recipes/' + result.id

	details: (req, res) ->
		res.render 'recipes/details', { refId: req.refId }

	edit: (req, res) ->
		console.log JSON.stringify req.recipeCommit, null, '\t'
		res.render 'recipes/edit', { recipeCommit: req.recipeCommit }

