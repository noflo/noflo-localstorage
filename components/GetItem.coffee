noflo = require 'noflo'

class GetItem extends noflo.Component
  constructor: ->
    @inPorts =
      key: new noflo.Port 'string'
    @outPorts =
      item: new noflo.Port 'string'
      error: new noflo.Port 'object'

exports.getComponent = -> new GetItem
