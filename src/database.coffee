mongoose = require 'mongoose'
config = require '../config'

mongoose.connect config.databaseConnectionString

exports.Recipe = mongoose.model 'Recipe',
	name: String
	author: String
	description: String
	picture: Buffer
	ingredients: [{
		qty: Number
		description: String
	}]

exports.User = mongoose.model 'User',
	name: String
	username: String
	email: String