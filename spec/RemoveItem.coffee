noflo = require 'noflo'
RemoveItem = require 'noflo-localstorage/components/RemoveItem.js'

describe 'RemoveItem component', ->
  c = null
  key = null
  beforeEach ->
    c = RemoveItem.getComponent()
    key = noflo.internalSocket.createSocket()
    c.inPorts.key.attach key

  describe 'when removing a key', ->
    localStorage.setItem 'RemoveItem', 'foo'
    it 'should be able to remove it', (done) ->
      key.send 'RemoveItem'
      setTimeout ->
        val = localStorage.getItem 'RemoveItem'
        chai.expect(val).to.be.a 'null'
        done()
      , 0
