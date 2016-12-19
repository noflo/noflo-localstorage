noflo = require 'noflo'
baseDir = 'noflo-dom'

describe 'GetItem component', ->
  c = null
  key = null
  item = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'localstorage/GetItem', (err, instance) ->
      return done err if err
      c = instance
      key = noflo.internalSocket.createSocket()
      c.inPorts.key.attach key
      done()
  beforeEach ->
    item = noflo.internalSocket.createSocket()
    c.outPorts.item.attach item
  afterEach ->
    c.outPorts.item.attach item
    item = null

  describe 'when instantiated', ->
    it 'should have an key port', ->
      chai.expect(c.inPorts.key).to.be.an 'object'
    it 'should have an item port', ->
      chai.expect(c.outPorts.item).to.be.an 'object'
    it 'should have an error port', ->
      chai.expect(c.outPorts.error).to.be.an 'object'

  describe 'fetching an existing key', ->
    localStorage.setItem 'GetItem', 'foo'
    it 'should be able to fetch it', (done) ->
      item.on 'data', (data) ->
        chai.expect(data).to.equal 'foo'
        localStorage.removeItem 'GetItem'
        done()
      key.send 'GetItem'

  describe 'fetching a missing key', ->
    it 'should send an error', (done) ->
      err = noflo.internalSocket.createSocket()
      c.outPorts.error.attach err
      err.on 'data', (data) ->
        chai.expect(data).to.be.an 'error'
        done()
      key.send 'GetItemNotDefined'
