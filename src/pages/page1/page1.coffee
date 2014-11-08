tpl = require "./page1.html"
GuidePage =  require "../../../lib/pages/guide/guide.coffee"

class page1 extends GuidePage
    constructor: (data)->
        @tpl = tpl
        @data = data or {}
        @render()
        super()
    start: ->
        super()
    stop: ->
        super()

module.exports = page1
