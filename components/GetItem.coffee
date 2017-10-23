noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Get an item from LocalStorage'
  c.inPorts.add 'key',
    datatype: 'string'
  c.outPorts.add 'item',
    datatype: 'string'
  c.outPorts.add 'error',
    datatype: 'object'
  c.forwardBrackets =
    key: ['item', 'error']
  c.process (input, output) ->
    return unless input.hasData 'key'
    key = input.getData 'key'
    value = localStorage.getItem key
    unless value
      output.done new Error "#{key} not found"
      return
    output.sendDone
      item: value
    return
