require!{
  '../consts'
  './repository_base'
  '../schemas/curriculum_schema'
}

class curriculum_repository extends repository_base
  ->
    super consts.CONFIGURE.env.mongo
    @model = @connection.model 'curriculum', curriculum_schema

module.exports = curriculum_repository