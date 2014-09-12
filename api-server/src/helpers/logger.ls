require! log4js
class logger
  @get-logger = (category) ->
    log4js.getLogger category

module.exports = logger