path = require "path"
express = require "express"

log4js = require "log4js"
routes = require "./lib/routes"

app = express()
# options
app.enable "case sensitive routing"

# configuration
log4js.configure "config/log4js.config", {}

dateFileLog = log4js.getLogger "normal"
app.use log4js.connectLogger(dateFileLog, { level: "debug", format: ":method :url"})

# all
app.use express.static path.join(__dirname, "/public")

# development
if "development" == app.get "env"
  console.log "run as development.."


# production
if "production" == app.get "env"
  console.log "run as production.."



# route
routes app

# 404
app.use (req, res, next) ->
  err = new Error("Not Found")
  err.status = 404
  next err

# err
if "development" == app.get "env"
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.send
      message: err.message,
      error: err.stack

if "production" == app.get "env"
  0

app.use (err, req, res, next) ->
  res.status err.status or 500
  res.send
    message: err.message

module.exports = app