noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Remove an item from LocalStorage'
  c.icon = 'trash'
  c.inPorts.add 'key',
    datatype: 'string'
  c.outPorts.add 'item',
    datatype: 'string'
  c.forwardBrackets =
    key: ['item']
  c.process (input, output) ->
    return unless input.hasData 'key'
    key = input.getData 'key'
    localStorage.removeItem key
    output.sendDone
      item: null
    return
