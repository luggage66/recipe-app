db = require './database'
async = require 'async'

module.exports = 
	getRef: (id, done) ->
		db.RecipeRef.findById id, done

	getCommit: (commitId, done) ->
		async.waterfall [
				(done) ->
					db.RecipeCommit.findById commitId, done
				(commit, done) ->
					db.RecipeCommit.populate commit, [{path: 'data'}], done
			], done