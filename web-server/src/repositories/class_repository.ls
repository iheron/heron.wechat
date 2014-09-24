require!{
  '../consts'
  './repository_base'
  '../schemas/class_schema'
}

class class_repository extends repository_base
  ->
    super consts.CONFIGURE.env.mongo
    @model = @connection.model 'class', class_schema

module.exports = class_repository