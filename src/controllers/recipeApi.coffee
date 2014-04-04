express = require 'express'
core = require '../core'

module.exports = app = new express

app.param ':recipeRefId', (req, res, next, id) -> 
	req.refId = id;
	core.getRef id, (err, ref) ->
		if err
			next err
		else
			core.getCommit ref.head, (err, commit) ->
				if err
					next err
				else
					req.recipeCommit = commit
					next()

app.get '/ref/:recipeRefId', (req, res) ->
	res.json req.recipeCommit