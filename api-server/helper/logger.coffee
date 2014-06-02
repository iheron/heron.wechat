log4js = require "log4js"

logger = ->
logger.getLogger = (category = "default") ->
  log4js.getLogger(category)

module.exports = logger