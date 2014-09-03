require! "../src/app"
port = 4000
server = app.listen port, !-> console.log "api server listening on port #{server.address().port}"