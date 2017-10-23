noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Remove an item from a list'
  c.icon = 'trash'
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
    unless items.indexOf(key) is -1
      items.splice items.indexOf(key), 1
      localStorage.setItem listKey, items.join ','
    output.sendDone
      key: key
    return
