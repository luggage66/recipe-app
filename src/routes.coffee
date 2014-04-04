home = require './controllers/home'
recipes = require './controllers/recipes'
users = require './controllers/users'

module.exports = (app) ->

	#main site
	app.get '/', home.index

	#recipes
	app.get '/recipes', recipes.list
	app.get '/recipes/create', recipes.create
	app.post '/recipes/create', recipes.save
	app.post '/recipes/:recipeId', recipes.save
	app.param ':recipeRefId', recipes.lookupRef
	app.get '/recipes/:recipeRefId', recipes.viewHead
	app.get '/recipes/:recipeRefId/*', recipes.viewHead
	# app.get '/recipes/:recipeId/edit', recipes.edit


	#users
	app.get '/users/login', users.login
	app.get '/users/create', users.create
	app.post '/users/:userId', users.save
	app.param ':userId', users.lookup
	app.get '/users/view', users.view