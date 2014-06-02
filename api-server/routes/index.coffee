express = require "express"
api  = require "./api_route"

module.exports = (app) ->
  app.use "/api", api