fs = require "fs"
_ = require "underscore"


class file
  ###*
  # 根据正则取得文件名, 并去重
  # @param: dir   # 文件路径
  # @param: reg1  # 名字正则
  # @param: reg2  # 二次正则
  ###
  @getRouteFileSync: (dir) ->
    files = fs.readdirSync dir
    route_files = _.filter files, (item) -> /.*route(?=\.).*/i.test item
    routes = _.union _.map route_files, (route) -> route.replace /\..*/i, ""
    routes = _.map routes, (item) ->
      route_match = item.match /.*(?=route)/i
      route = route_match[0]
      route = route.replace /_$/i, ""
      [ route , item ]

  @getControllerFileSync: (dir) ->
    files = fs.readdirSync dir
    route_files = _.filter files, (item) -> /.*controller(?=\.).*/i.test item
    routes = _.union _.map route_files, (route) -> route.replace /\..*/i, ""
    routes = _.map routes, (item) ->
      controller_match = item.match /.*(?=controller)/i
      controller = controller_match[0]
      controller = controller.replace /_$/i, ""
      [ controller , item ]

module.exports = file