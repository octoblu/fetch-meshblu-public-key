shmock         = require 'shmock'
enableDestroy  = require 'server-destroy'
NodeRSA        = require 'node-rsa'
validPublicKey = require './valid-public-key.json'
FetchPublicKey = require '../'

describe 'Fetch', ->
  beforeEach ->
    @server = shmock 0xd00d
    enableDestroy @server
    @sut = new FetchPublicKey

  afterEach ->
    @server.destroy()

  describe 'when called with a valid request', ->
    beforeEach (done) ->
      @fetchRequest = @server.get '/publickey'
        .reply 200, validPublicKey

      @sut.fetch "http://localhost:#{0xd00d}/publickey", (error, @publicKey) =>
        done error

    it 'should make the fetch request', ->
      @fetchRequest.done()

    it 'should be valid public key', ->
      key = new NodeRSA()
      key.importKey(new Buffer(@publicKey.publicKey), 'public')
      expect(key.isPublic()).to.be.true

  describe 'when called with a invalid request', ->
    beforeEach (done) ->
      @fetchRequest = @server.get '/publickey'
        .reply 200, { publicKey: 'this-definitely-will-not-work' }

      @sut.fetch "http://localhost:#{0xd00d}/publickey", (@error, @publicKey) =>
        done()

    it 'should make the fetch request', ->
      @fetchRequest.done()

    it 'should have an error', ->
      expect(@error.message).to.equal 'Invalid PublicKey'


  describe 'when called with an empty request', ->
    beforeEach (done) ->
      @fetchRequest = @server.get '/publickey'
        .reply 200, { publicKey: null }

      @sut.fetch "http://localhost:#{0xd00d}/publickey", (@error, @publicKey) =>
        done()

    it 'should make the fetch request', ->
      @fetchRequest.done()

    it 'should have an error', ->
      expect(@error.message).to.equal 'Invalid PublicKey'

  describe 'when called with an invalid request uri', ->
    beforeEach (done) ->
      @fetchRequest = @server.get '/publickey'
        .reply 502, 'Bad Gateway'

      @sut.fetch "http://localhost:#{0xd00d}/publickey", (@error, @publicKey) =>
        done()

    it 'should make the fetch request', ->
      @fetchRequest.done()

    it 'should have an error', ->
      expect(@error.message).to.equal 'Invalid Response Code: 502'
