app = require "../app"

app.set "port", process.env.PORT or 4000

server = app.listen (app.get "port"), ->
  console.log "api server listening on port #{server.address().port}"