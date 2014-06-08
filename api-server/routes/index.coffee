express = require "express"
api  = require "./api_route"

#todo 优化加载逻辑，映射到文件
module.exports = (app) ->
  app.use "/api", api