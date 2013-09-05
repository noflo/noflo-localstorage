noflo = require 'noflo'
SetItem = require 'noflo-localstorage/components/SetItem.js'

describe 'SetItem component', ->
  c = null
  key = null
  value = null
  item = null
  beforeEach ->
    c = SetItem.getComponent()
    key = noflo.internalSocket.createSocket()
    value = noflo.internalSocket.createSocket()
    item = noflo.internalSocket.createSocket()
    c.inPorts.key.attach key
    c.inPorts.value.attach value
    c.outPorts.item.attach item

  describe 'when instantiated', ->
    it 'should not hold a key', ->
      chai.expect(c.key).to.equal null
    it 'should not hold a value', ->
      chai.expect(c.value).to.equal null

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
