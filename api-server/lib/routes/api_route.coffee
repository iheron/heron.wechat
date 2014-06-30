express = require "express"
controller = require "../controllers/api_controller"

router = express.Router({ caseSensitive: true })

router.route "/wechat"
.get controller.wechat.get
.post controller.wechat.post

module.exports = router
