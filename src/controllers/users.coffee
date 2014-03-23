db = require '../database'

module.exports =
	create: (req, res) ->
		res.render 'users/create'

	save: (req, res, next) ->
		user = new db.User(req.body)

		user.save (err, data) ->
			if err
				next(err)

			if req.xhr #ajax
				res.json data
			else
				res.redirect '/'

	login: (req, res) ->
		res.render 'users/login'

	view: (req, res) ->
		res.render 'users/view', { user: req.user }

	lookup: (req, res, next, id) -> 
		db.User.findById id, (err, user) ->
		if err
			next err
		else
			req.user = user
			next()