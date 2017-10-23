noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Listen for changes in localStorage'
  c.icon = 'hourglass'
  c.inPorts.add 'start',
    datatype: 'bang'
  c.inPorts.add 'stop',
    datatype: 'bang'
  c.outPorts.add 'changed',
    datatype: 'object'
  c.outPorts.add 'removed',
    datatype: 'object'
  c.listeners = {}
  unsubscribe = (scope) ->
    return unless c.listeners[scope]
    window.removeEventListener 'storage', c.listeners[scope].callback, false
    c.listeners[scope].ctx.deactivate()
  c.tearDown = (callback) ->
    for scope, val of c.listeners
      unsubscribe scope
    c.listeners = {}
    do callback
  c.process (input, output, context) ->
    if input.hasData 'stop'
      input.getData 'stop'
      unsubscribe input.scope
      output.done()
      return
    if input.hasData 'start'
      input.getData 'start'
      # Ensure previous context gets cleared
      unsubscribe input.scope
      listener =
        ctx: context
        callback: (event) ->
          if event.newValue is null
            # Removed key
            output.send
              removed:
                key: event.key
                value: null
            return
          output.send
            changed:
              key: event.key
              value: event.newValue
          return
      window.addEventListener 'storage', listener.callback, false
      c.listeners[input.scope] = listener
      return
