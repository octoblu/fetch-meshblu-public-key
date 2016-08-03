colors        = require 'colors'
dashdash      = require 'dashdash'

packageJSON = require './package.json'

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
    {@example} = @parseOptions()

  parseOptions: =>
    parser = dashdash.createParser({options: OPTIONS})
    options = parser.parse(process.argv)

    if options.help
      console.log "usage: fetch-meshblu-public-key [OPTIONS]\noptions:\n#{parser.help({includeEnv: true})}"
      process.exit 0

    if options.version
      console.log packageJSON.version
      process.exit 0

    if !options['meshblu-public-key-uri']
      console.error "usage: fetch-meshblu-public-key [OPTIONS]\noptions:\n#{parser.help({includeEnv: true})}"
      console.error colors.red 'Missing required parameter --example, -e, or env: EXAMPLE'
      process.exit 1

    return options

  run: =>
    console.log "Hi Example! #{@example}"

  die: (error) =>
    return process.exit(0) unless error?
    console.error 'ERROR'
    console.error error.stack
    process.exit 1

module.exports = Command
