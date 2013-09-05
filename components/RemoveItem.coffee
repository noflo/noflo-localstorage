noflo = require 'noflo'

class RemoveItem extends noflo.Component
  constructor: ->
    @inPorts =
      key: new noflo.Port 'string'
    @outPorts = {}

    @inPorts.key.on 'data', (data) =>
      localStorage.removeItem data

exports.getComponent = -> new RemoveItem
