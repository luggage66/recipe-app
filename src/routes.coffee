home = require './controllers/home'
recipes = require './controllers/recipes'

module.exports = (app) ->

	#main site
	app.get '/', home.index

	#recipes
	app.get '/recipes', recipes.list
	app.get '/recipes/create', recipes.create
	app.post '/recipes/create', recipes.save
	app.param ':recipeId', recipes.lookup
	app.get '/recipes/:recipeId', recipes.details
