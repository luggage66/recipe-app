mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/test'

exports.Recipe = mongoose.model 'Recipe',
	name: String
	author: String
	ingredients: [{
		qty: Number,
		description: String
	}]
