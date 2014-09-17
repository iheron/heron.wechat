require!{
  mongoose
}

setting-schema = new mongoose.Schema do
  welcome:
    type: String

module.exports = setting-schema