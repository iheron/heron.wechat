require!{
  '../consts'
  '../helpers/redis': redis-client
}
class @index
  @get = ->*
    @body = 'ok'

class @test
  @get = ->*
    redis = new redis-client!

    data = yield (done) -> redis.keys '*', (err, data) ->
      done err, data.[1 to 3]



    @body = data

