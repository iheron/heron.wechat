require!{
  '../consts'
  './repository_base'
  '../schemas/setting_schema'
}

class setting_repository extends repository_base
  ->
    super consts.CONFIGURE.development.mongo
    @model = @connection.model 'setting', setting_schema

module.exports = setting_repository