
class @login
  @get: (req, res, next) ->
    res.render "account/login",
      message: req.flash "error"


class @register
  @get: (req, res, next) ->
    res. send "ok"

module.exports = @
