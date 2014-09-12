require!{
  '../consts'
  '../helpers/redis': redis-client
}
class @index
  @get = ->*
    @body = 'ok'

class @test
  @get = ->*
    @res.writeHead(200, {'Content-Type': 'text/plain'})
    @res.end 'ok121'

