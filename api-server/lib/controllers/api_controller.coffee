consts = require "../consts/consts"
express = require "express"
helper_wechat = require("../helper/wechat")(consts.WECHAT_TOKEN)
logger = require "../helper/logger"
.getLogger("api_controller")


class @wechat
  @get: (req, res, next) ->
    if not helper_wechat.checkSignature(req.query)
      logger.error req.query
      res.send 200, ""
    else
      res.send 200, req.query.echostr

  @post: (req, res, next) ->
    if not helper_wechat.checkSignature(req.query)
      logger.error req.query
      res.send 200, ""
    else
      helper_wechat.getMsg req, (data) ->
        console.log data
        msg =
          FromUserName: data.ToUserName
          ToUserName: data.FromUserName
          Content: """demo: 最近的上课时间是 2014-06-09 周一 数据结构，上课时间：18:30，地点：3-301。作业进度：<a href="#">点击查看详情</a>"""
        xml = helper_wechat.parseMsg msg
        res.send xml

module.exports = @