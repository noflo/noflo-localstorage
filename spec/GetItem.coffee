noflo = require 'noflo'
GetItem = require 'noflo-localstorage/components/GetItem.js'

describe 'GetItem component', ->
  c = null
  ins = null
  out = null
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
