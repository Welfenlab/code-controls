
uuid = require 'node-uuid'

module.exports = (lang, runner, template) ->
  register: (md, postProcessors) ->
    origFence = md.renderer.rules.fence
    md.renderer.rules.fence = (tokens, idx)=>
      fenceToken = tokens[idx]
      fencedContent = origFence.apply this, arguments
      if fenceToken.info == lang
        # ids must not begin with a number!
        id = "cc-#{uuid.v4()}"
        code = fenceToken.content
        fencedContent = template code: code, html: fencedContent, id: id


        postProcessors.registerElemenbById id, (elem, done) ->
          try
            playButton = elem.querySelector '.play'
            if playButton
              playButton.onclick = -> runner.run code

            debugButton = elem.querySelector '.debug'
            if debugButton
              debugButton.onclick = -> runner.debug code

          # add error handler
          catch e
            console.warn e
          finally
            done()

      return fencedContent
