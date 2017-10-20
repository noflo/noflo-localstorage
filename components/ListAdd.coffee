noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.inPorts.add 'list',
    datatype: 'string'
    control: true
  c.inPorts.add 'key',
    datatype: 'string'
  c.outPorts.add 'key',
    datatype: 'string'
  c.forwardBrackets =
    key: ['key']
  c.process (input, output) ->
    return unless input.hasData 'list', 'key'
    [listKey, key] = input.getData 'list', 'key'
    list = localStorage.getItem listKey
    if list
      items = list.split ','
    else
      items = []
    if items.indexOf(key) is -1
      items.push key
      localStorage.setItem listKey, items.join ','
    output.sendDone
      key: key
    return
