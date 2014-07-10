path = require "path"
express = require "express"
favicon = require "static-favicon"
bodyParser = require "body-parser"
cookieParser = require "cookie-parser"
session = require "express-session"
flash = require "connect-flash"
passport = require "passport"
LocalStrategy = require "passport-local"
.Strategy

consts = require "./lib/consts/consts"
log4js = require "log4js"
routes = require "./lib/routes"

app = express()
# options
app.enable "case sensitive routing"

# configuration
# log4js
log4js.configure "config/log4js.config", {}
dateFileLog = log4js.getLogger "normal"
app.use log4js.connectLogger(dateFileLog, { level: "debug", format: ":method :url" })

# all
app.set "views", (path.join __dirname, "views")
app.set "view engine", "hjs"
app.set "layout", "partials/_layout"
app.set "partials",
  bootstrap_header_link: "partials/bootstrap/header_link"
  bootstrap_footer_link: "partials/bootstrap/footer_link"
  footer_link: "partials/footer_link"
  footer: "partials/footer"
#app.enable "view cache"
app.engine "hjs", require "hogan-express"

app.use favicon()
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: true })
app.use cookieParser(consts.SECRET)
app.use session({ secret: consts.SECRET })
app.use flash()
app.use passport.initialize()
app.use passport.session()
app.use express.static path.join(__dirname, "/public")
passport.use "local", new LocalStrategy (username, password, done) ->
  user =
    id: "1"
    username: "admin"
    password: "pass"
  if username != user.username
    return done null, false, { message: "Incorrect username." }
  if password != user.password
    return done null, false, { message: "Incorrect password." }
  return done null, user

passport.serializeUser (user, done) ->
  done(null, user)


passport.deserializeUser (user, done) ->
  done(null, user)

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
    err_status = err.status or 500
    res.status err_status
    res.render "error/#{err_status}",
      message: err.message
      error: err

if "production" == app.get "env"
  0

app.use (err, req, res, next) ->
  err_status = err.status or 500
  res.status err_status
  res.render "error/#{err_status}",
    message: err.message
    error: {}

module.exports = app