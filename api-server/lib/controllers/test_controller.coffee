logger = require "../helper/logger"
.getLogger("test_controller")

class @action1
  @get: (req, res, next) ->
    res.send "get in test"
  @post: (req, res, next) ->
    res.send "post in test"

class @action
  @get: (req, res, next) ->
    res.send "get"

module.exports = @