require! {
  path
  fs
  koa
  log4js
  'koa-static'
  'koa-mount': mount
  'koa-router': koa-router
  'co-views': views
  'heron-mvc': mvc
}
require! {
  './helper/views': views
}
app = koa!

# configuration
# log4js
logger = (next) ->*
  log4js.configure 'configure/log4js.json', {}
  dateFileLog = log4js.getLogger 'normal'
  log4js.connectLogger(dateFileLog, { level: 'debug', format: ':method :url' })
  yield next
app.use logger
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
    @body = 'Page Not Found'
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
      @status = e.status || 500
      @type = 'html'
      @body = 'error 500'
      @app.emit 'error', e, @
  app.use error

if 'production' == app.env
  0

error = (next) ->*
  try
    yield next
  catch e
    @status = e.status || 500
    @type = 'html'
    @body = 'error 500'
    @app.emit 'error', e, @
app.use error
app.on 'error' (err) !->
  console.log err
  return



# route
mvc.route.load do
  route-dir: path.join(__dirname, './routes'),
  controller-dir: path.join(__dirname, './controllers')
  , (data) ->

  , (data) ->
    router = new koa-router!
    router[data.method] "/#{data.controller}/#{data.action}", data.func
    if data.controller == 'home' && data.action == 'index'
      router[data.method] "/", data.func
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

views.hogan.layout = 'partials/_layout'
views.hogan.partials = {bootstrap_header_link: '../partials/bootstrap/header_link', footer_link: '../partials/footer_link', header_link: '../partials/header_link', bootstrap_footer_link:'../partials/bootstrap/footer_link'}
app.use mount '/test', ->*
  @body = yield views.hogan.render 'home/index',{partials:{footer:'../partials/footer'}}


module.exports = app