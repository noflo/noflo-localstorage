noflo = require 'noflo'
baseDir = 'noflo-dom'

describe 'RemoveItem component', ->
  c = null
  key = null
  item = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'localstorage/RemoveItem', (err, instance) ->
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

  describe 'when removing a key', ->
    localStorage.setItem 'RemoveItem', 'foo'
    it 'should be able to remove it', (done) ->
      item.on 'data', (data) ->
        chai.expect(data).to.be.a 'null'
        # Ensure that it has been removed
        val = localStorage.getItem 'RemoveItem'
        chai.expect(val).to.be.a 'null'
        done()
      key.send 'RemoveItem'
