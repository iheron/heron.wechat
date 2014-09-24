require! {
  '../repositories/curriculum_repository': curm_rep
  '../helpers/views': views
}

class @list
  @get = ->*
    curm-rep = new curm_rep!
    data = yield (done) ->
      curm-rep.findAll do
        class-id: '54226f9bd3b74372fc21d9a9'
        , done
    @body = yield views.hogan.render 'curriculum/list', do
      data: data