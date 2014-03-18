mongoose = require 'mongoose'
config = require '../config'

mongoose.connect config.databaseConnectionString

exports.Recipe = mongoose.model 'Recipe',
	name: String
	author: String
	ingredients: [{
		qty: Number,
		description: String
	}]
