noflo = require 'noflo'
RemoveItem = require 'noflo-localstorage/components/RemoveItem.js'

describe 'RemoveItem component', ->
  c = null
  key = null
  item = null
  beforeEach ->
    c = RemoveItem.getComponent()
    key = noflo.internalSocket.createSocket()
    item = noflo.internalSocket.createSocket()
    c.inPorts.key.attach key
    c.outPorts.item.attach item

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
