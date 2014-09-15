require!{
  co
  '../consts'
  '../helpers/redis': redis-client
  '../helpers/flash'
}
class @index
  @get = ->*
    @body = 'ok'

class @test
  @get = ->*
#    redis = new redis-client!
#    id = @request.query.id
##    data = yield (done) -> redis.keys '*', (err, data) ->
##      done err, data.[1 to 3]
#
#    isexists = yield (done) -> redis.exists id, (err, data) -> done err, data
#
#    if isexists
#      data = isexists + '........... isd'
#    else
#      data = yield (done) -> redis.set id, 'value', (err, flag) ->
#        if 'OK' == flag
#          redis.expire id, 10, (err, flag) ->
#            done err, flag


    @body = yield (done) ->
      co flash.yield-is-exists @request.query.id, 3
      <| (err, res) ->
        done err, res

