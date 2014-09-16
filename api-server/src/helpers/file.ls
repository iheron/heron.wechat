class file
  @loadConfigFileSync = (path) ->
    if path
      return JSON.parse fs.readFileSync path, 'utf8'
    undefined

module.exports = file