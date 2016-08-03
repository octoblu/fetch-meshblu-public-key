colors        = require 'colors'
dashdash      = require 'dashdash'
request       = require 'request'
fs            = require 'fs'
path          = require 'path'
packageJSON   = require './package.json'

OPTIONS = [{
  names: ['meshblu-public-key-uri', 'm']
  type: 'string'
  env: 'MESHBLU_PUBLIC_KEY_URI'
  help: 'Meshblu public key uri'
}, {
  names: ['help', 'h']
  type: 'bool'
  help: 'Print this help and exit.'
}, {
  names: ['version', 'v']
  type: 'bool'
  help: 'Print the version and exit.'
}]

class Command
  constructor: ->
    process.on 'uncaughtException', @die
    options = @parseOptions()
    @uri = options['meshblu-public-key-uri'] ? 'https://meshblu.octoblu.com/publickey'

  parseOptions: =>
    parser = dashdash.createParser({options: OPTIONS})
    options = parser.parse(process.argv)

    if options.help
      console.log "usage: fetch-meshblu-public-key [OPTIONS]\noptions:\n#{parser.help({includeEnv: true})}"
      process.exit 0

    if options.version
      console.log packageJSON.version
      process.exit 0

    return options

  getWriteStream: =>
    filePath = path.join process.cwd(), 'public-key.json'
    fs.createWriteStream filePath

  getRequestStream: (callback) =>
    stream = request.get @uri
    stream.on 'error', callback
    stream.on 'response', (response) =>
      return callback new Error('Invalid public-key-uri') if response.statusCode >= 400
      callback null, stream

  run: =>
    @getRequestStream (error, stream) =>
      return @die error if error?
      stream.pipe @getWriteStream()

  die: (error) =>
    return process.exit(0) unless error?
    console.error 'ERROR'
    console.error error.stack
    process.exit 1

module.exports = Command
