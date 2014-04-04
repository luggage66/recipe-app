mongoose = require 'mongoose'
config = require '../config'
ObjectId = mongoose.Schema.ObjectId

mongoose.connect config.databaseConnectionString

exports.RecipeCommit = mongoose.model 'RecipeCommit',
	parents: [ { type: ObjectId, ref: 'RecipeCommit' } ]
	data: { type: ObjectId, ref: 'RecipeData' }
	author: String
	
exports.RecipeData = mongoose.model 'RecipeData',
	description: String
	name: String
	ingredients: [{
		qty: Number
		description: String
	}]
	steps: [{
		body: String
	}]

exports.RecipeRef = mongoose.model 'RecipeRef',
	name: String
	head: { type: ObjectId, ref: 'RecipeCommit' }

exports.User = mongoose.model 'User',
	name: String
	username: String
	email: String

