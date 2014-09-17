require!{
  koa
  path
  redis
  '../consts'
}
app = koa!

logger = require '../helpers/logger'
.get-logger 'redis'

class redis-client
  (redis-config = consts.CONFIGURE.env.redis) ->
    [ port, host, options ] = [ redis-config.port, redis-config.host, redis-config.options ]
    return redis.createClient(port, host, options)


module.exports = redis-client