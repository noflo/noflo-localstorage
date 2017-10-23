noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Get an item from a list'
  c.inPorts.add 'key',
    datatype: 'string'
  c.outPorts.add 'items',
    datatype: 'string'
  c.outPorts.add 'error',
    datatype: 'object'
  c.forwardBrackets =
    key: ['items', 'error']
  c.process (input, output) ->
    return unless input.hasData 'key'
    key = input.getData 'key'
    value = localStorage.getItem key
    unless value
      output.done new Error "#{key} not found"
      return
    list = value.split ','
    output.send
      items: new noflo.IP 'openBracket', key
    for item in list
      output.send
        items: item
    output.send
      items: new noflo.IP 'closeBracket', key
    output.done()
    return
