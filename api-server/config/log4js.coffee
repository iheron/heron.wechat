log4js = require "log4js"

log4js.configure "config/log4js.config", {}

dateFileLog = log4js.getLogger "default"

module.exports = (app) ->
  app.use log4js.connectLogger(dateFileLog, { level: "debug", format: ":method :url"})