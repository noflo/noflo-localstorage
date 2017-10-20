noflo = require 'noflo'
baseDir = 'noflo-dom'

describe 'SetItem component', ->
  c = null
  key = null
  value = null
  item = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'localstorage/SetItem', (err, instance) ->
      return done err if err
      c = instance
      key = noflo.internalSocket.createSocket()
      c.inPorts.key.attach key
      value = noflo.internalSocket.createSocket()
      c.inPorts.value.attach value
      done()
  beforeEach ->
    item = noflo.internalSocket.createSocket()
    c.outPorts.item.attach item
  afterEach ->
    c.outPorts.item.attach item
    item = null

  describe 'when receiving key and a value', ->
    it 'should send it out', (done) ->
      item.on 'data', (data) ->
        chai.expect(data).to.equal 'foo'
        done()
      key.send 'SetItem'
      value.send 'foo'
    it 'should have set the item to LocalStorage', ->
      val = localStorage.getItem 'SetItem'
      chai.expect(val).to.equal 'foo'
      localStorage.removeItem 'SetItem'
