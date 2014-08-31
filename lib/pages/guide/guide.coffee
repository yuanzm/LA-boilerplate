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

    _reset: ->
        TweenMax.set @$tip, {autoAlpha: 0}

LA.util.exports GuidePage 
module.exports = GuidePage 