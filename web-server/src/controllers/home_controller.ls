require! {
  '../helper/views': views
}

class @index
  @get = ->*
    @body = yield views.hogan.render 'home/index'