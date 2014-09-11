require! log4js
class logger
  @getLogger = (category) ->
    log4js.getLogger category

module.exports = logger