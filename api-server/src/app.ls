require! {
  path
  fs
  koa
  log4js
  'koa-static'
  'koa-mount': mount
  'koa-router': router
  'co-views': views
  'heron-mvc': mvc
}
logger = require './helpers/logger'
.getLogger 'app'
app = koa!
console.log process
# configuration
# log4js
log4js.configure 'config/log4js.json', {}
dateFileLog = log4js.getLogger 'normal'
log4js.connectLogger(dateFileLog, { level: 'debug', format: ':method :url' })

# all
app.use koa-static path.join __dirname, '../public'

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
  logger.error err
  return

module.exports = app