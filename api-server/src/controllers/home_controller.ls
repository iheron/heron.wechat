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
    rep = new setting_repository!
    @body = yield (done) -> rep.findAll done