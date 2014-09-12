require! {
  path
  fs
  koa
  log4js
  'koa-static'
  'koa-mount': mount
  'koa-router': koa-router
  'heron-mvc': mvc
  './helpers/views': views
}
app = koa!

# configuration
# log4js
log4js.configure 'configure/log4js.json', {}
logger = log4js.getLogger 'normal'
log4js-middleware = (next) ->*
  log4js.connectLogger(logger, { level: 'debug', format: ':method :url' })
  logger.debug "#{@request.method} #{@request.url}"
  yield next
app.use log4js-middleware
app.use koa-static path.join __dirname, '../public'

# all

# 404
page-not-found = (next) ->*
  yield next
  if @status != 404 then return
  @status = 404
  switch (@accepts 'html', 'json')
  | 'html' =>
    @type = 'html'
    @body = yield views.hogan.render 'error/404'
  | 'json' =>
    @body =
      message: 'Page Not Found'
  | _ =>
    @type = 'text'
    @body = 'Page Not Found'
app.use page-not-found


# error
if 'development' == app.env
  error = (next) ->*
    try
      yield next
    catch e
      e.status ?= 500
      @status = e.status
      @type = 'html'
      @body = yield views.hogan.render 'error/500', do
        message: error.message
        error: e
      @app.emit 'error', e, @
  app.use error

if 'production' == app.env
  error = (next) ->*
    try
      yield next
    catch e
      @status = e.status || 500
      @type = 'html'
      @body = yield views.hogan.render 'error/500', do
          message: error.message
      @app.emit 'error', e, @
  app.use error

app.on 'error' (err) !->
  console.log err
  return

# route
views.hogan.layout = 'partials/_layout'
router = new koa-router!
mvc.route.load do
  route-dir: path.join(__dirname, './routes'),
  controller-dir: path.join(__dirname, './controllers')
  , (data) ->

  , (data) ->
    router.[data.method] "/#{data.controller}/#{data.action}", data.func
    if data.controller == 'home' && data.action == 'index'
      router.[data.method] "/", data.func
app.use router.middleware!


app.use mount '/demo', ->*
  h = yield render 'home/index', {}
  a = render 'partials/_layout', {title:'home',partials:{footer:'footer'}}
#  b = render 'home/index', {}
#  c = render 'partials/footer', {}
#  d = render 'partials/footer_link', {}
#  e = render 'partials/bootstrap/header_link', {}
#  f = render 'partials/bootstrap/footer_link', {}
  html = yield [a]
  html = html.join '\n'
  @body = html

app.use mount '/test', ->*
  @body = yield views.hogan.render 'home/index',{partials:{footer:'../partials/footer'}}


module.exports = app