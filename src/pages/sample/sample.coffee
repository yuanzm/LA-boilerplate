tpl = require "./sample.html"
GuidePage =  require "../../../lib/pages/guide/guide.coffee"

class SamplePage extends GuidePage
    constructor: (data)->
        @tpl = tpl
        @data = data or {}
        @render()
        super()
    start: ->
        super()
    stop: ->
        super()

module.exports = SamplePage
