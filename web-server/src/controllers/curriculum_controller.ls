require! {
  '../helpers/views': views
}

class @list
  @get = ->*
    @body = yield views.hogan.render 'curriculum/list'