tpl = require "./guide.html"

class GuidePage extends LA.PageController
    constructor: (data)->
        @$dom.append $(tpl)
        @$tip = @$dom.find "div.swipe-tip"
        @stop()
    start: -> 
        @$tip.show()

    stop: ->
        @$tip.hide()

LA.util.exports GuidePage 
module.exports = GuidePage 