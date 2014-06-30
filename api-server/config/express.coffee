express = require "express"
path = require "path"
consts = require "./../lib/consts/consts"
module.exports = (app) ->
  # all

  app.use express.static path.join(__dirname, "../public")

  # development
  if "development" == app.get "env"
    console.log "run as development.."


  # production
  if "production" == app.get "env"
    console.log "run as production.."