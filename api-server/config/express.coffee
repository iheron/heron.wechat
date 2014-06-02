express = require "express"
logger = require "morgan"
path = require "path"

module.exports = (app) ->
  # all
  app.use logger("dev")
  app.use express.static(path.join(__dirname, "public"))

  # development
  if "development" == app.get "env"
    0

  # production
  if "production" == app.get "env"
    0