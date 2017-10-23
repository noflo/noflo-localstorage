noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Save an item into LocalStorage'
  c.inPorts.add 'key',
    datatype: 'string'
  c.inPorts.add 'value',
    datatype: 'string'
  c.outPorts.add 'item',
    datatype: 'string'
  c.forwardBrackets =
    key: ['item']
  c.process (input, output) ->
    return unless input.hasData 'key', 'value'
    [key, value] = input.getData 'key', 'value'
    localStorage.setItem key, value
    output.sendDone
      item: value
    return
