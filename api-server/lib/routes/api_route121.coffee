express = require "express"
controller = require "./api_controller"

router = express.Router()

router.route "/wechat"
.get controller.wechat.get
.post controller.wechat.post

module.exports = router

