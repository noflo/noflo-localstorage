noflo = require 'noflo'
GetItem = require 'noflo-localstorage/components/GetItem.js'

describe 'GetItem component', ->
  c = null
  key = null
  item = null
  beforeEach ->
    c = GetItem.getComponent()
    key = noflo.internalSocket.createSocket()
    item = noflo.internalSocket.createSocket()
    c.inPorts.key.attach key
    c.outPorts.item.attach item

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
        chai.expect(data).to.be.an 'object'
        done()
      key.send 'GetItemNotDefined'
