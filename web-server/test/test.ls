require!{
  co
  redis
}
fn1 = (done) ->
  set-timeout ->
    done null, 'hello'
  , 100
fn2 = (done) ->
  set-timeout ->
    done null, 'word'
  , 50
fn3 = (count) ->
  (done) ->
    set-timeout ->
      done null, count
    , 10



main = ->*
  client = redis.createClient()
  res = yield (done) -> client.get key, done
  console.log res

main2 = (key) ->
  ->*
    client = redis.createClient()
    for i in [ 1 to 5]
      res = yield (done) -> client.get "#key#i", done
      console.log res

main3 = ->*
  for i in [ 1 to 3 ]
    console.log '--------'
    yield main2('key')
(co main3)!