require!{
  '../consts'
  '../helpers/redis': redis-client
}

class flash
  @yield-is-exists = (key, seconds = consts.FLASH_TIMEOUT) ->
    throw new Error('key is required.') if !key
    redis = new redis-client!
    ->*
      is-exists = yield (done) -> redis.exists key, (err, flag) -> done err, flag
      if 1 == is-exists
        return true
      else
        yield (done) -> redis.set key, '', (err, flag) ->
          if 'OK' == flag
            redis.expire key, seconds, (err, flag) ->
              done err, flag
        return false

module.exports = flash