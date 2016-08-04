request = require 'request'
fs      = require 'fs'
NodeRSA = require 'node-rsa'

class FetchPublicKey
  fetch: (uri, callback) =>
    request.get uri, { json: true }, (error, response, body) =>
      return callback error if error?
      return callback new Error("Invalid Response Code: #{response.statusCode}") if response.statusCode >= 400
      try
        { publicKey } = body
        key = new NodeRSA()
        key.importKey(new Buffer(publicKey), 'public')
      catch error
        return callback new Error('Invalid PublicKey')

      callback null, { publicKey }

  download: (uri, filePath, callback) =>
    @getRequestStream uri, (error, stream) =>
      return callback error if error?
      stream.on('end', callback).pipe @getWriteStream(filePath)

  getWriteStream: (filePath) =>
    fs.createWriteStream filePath

  getRequestStream: (uri, callback) =>
    stream = request.get uri
    stream.on 'error', callback
    stream.on 'response', (response) =>
      return callback new Error('Invalid public-key-uri') if response.statusCode >= 400
      callback null, stream

module.exports = FetchPublicKey
