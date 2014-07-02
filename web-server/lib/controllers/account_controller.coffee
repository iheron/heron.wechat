class @login
  @get: (req, res, next) ->
    res.render "account/login"

  @post: (req, res, next) ->
    res.send "ok"

class @register
  @get: (req, res, next) ->
    res. send "ok"

module.exports = @
