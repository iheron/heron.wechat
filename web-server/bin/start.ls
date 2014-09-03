require! "../lib/app"
port = 3000
server = app.listen port, !-> console.log "web server listening on port #{server.address().port}"