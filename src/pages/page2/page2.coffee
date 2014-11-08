tpl = require "./page2.html"
GuidePage =  require "../../../lib/pages/guide/guide.coffee"

class page2 extends GuidePage
    constructor: (data)->
        @tpl = tpl
        @data = data or {}
        @render()
        super()
    start: ->
        super()
    stop: ->
        super()

module.exports = page2
