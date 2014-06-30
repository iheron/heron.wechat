fs = require "fs"
path = require "path"
_ = require "underscore"
async = require "async"
express = require "express"
file = require "../helper/file"

logger = require "../helper/logger"
.getLogger("route_index")

# 如果有路由则使用自定义 否则 使用controllers
module.exports = (app) ->
  # load route
  routes = file.getRouteFileSync __dirname
  for route_arr in routes
    route = require "./" + route_arr[1]
    app.use "/#{route_arr[0]}", route
    logger.info "load router: %j -> path: /%s", route_arr, route_arr[0]


  controllers = file.getControllerFileSync (path.join __dirname, "../controllers")
  controllers = _.reject controllers, (controller) -> _.find routes, (route) -> route[0] == controller[0]
  logger.info "load all controller: %j", controllers
  for controller_arr in controllers
    controller = require "../controllers/" + controller_arr[1]
    router = express.Router({ caseSensitive: true })
    for action, methods of controller
      for k, v of methods
        switch k
          when "all"
            logger.info "load action: %s -> path: /%s -> method: /%s", action, (path.join controller_arr[0], action), k
            router.all "/#{action}", v
          when "get"
            logger.info "load action: %s -> path: /%s -> method: /%s", action, (path.join controller_arr[0], action), k
            router.get "/#{action}", v
          when "post"
            logger.info "load action: %s -> path: /%s -> method: /%s", action, (path.join controller_arr[0], action), k
            router.post "/#{action}", v
          when "put"
            logger.info "load action: %s -> path: /%s -> method: /%s", action, (path.join controller_arr[0], action), k
            router.put "/#{action}", v
          when "delete"
            logger.info "load action: %s -> path: /%s -> method: /%s", action, (path.join controller_arr[0], action), k
            router.delete "/#{action}", v
          else
            logger.info "not found method!"
        app.use "/#{controller_arr[0]}", router