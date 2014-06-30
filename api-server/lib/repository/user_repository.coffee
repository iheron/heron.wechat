consts = require "../consts/consts"
mongoose = require "mongoose"
user_schema = require "../schema/user_schema"
repository_base = require "./repository_base"

class user_repository extends repository_base
  constructor: ->
    super consts.MONGODB_CONFIG_PATH
    @model = @connection.model "user", user_schema

  findMaxAge: (next) ->
    @model.findOne().sort({ age: -1 }).exec(next)

module.exports = user_repository