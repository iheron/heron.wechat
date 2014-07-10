express = require "express"
passport = require "passport"
controller = require "../controllers/account_controller"

router = express.Router({ caseSensitive: true })

router.route "/login"
.get controller.login.get
.post passport.authenticate "local",
successRedirect: "/"
failureRedirect: "/account/login"
failureFlash: true

module.exports = router
