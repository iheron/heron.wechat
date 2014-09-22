require!{
  co
  '../consts'
  '../helpers/redis': redis-client
  '../helpers/flash'
  '../repositories/setting_repository'
}
class @index
  @get = ->*
    @body = 'ok'

class @test
  @get = ->*
    redis = new redis-client!
    @body = yield (done) -> redis.get 'key1', done