tpl = require "./guide.html"

class GuidePage extends LA.PageController
    constructor: (data)->
        @tipTl = new TimelineMax
        @$dom.append $(tpl)
        @$tip = @$dom.find "div.swipe-tip"
        @tipTl.to @$tip, 1, {autoAlpha: 1, y: -20, repeat: -1, yoyo: true}
        @stop()
    start: -> 
        @tipTl.restart()

    stop: ->
        @tipTl.kill()
        @_reset()

    _reset: ->
        TweenMax.set @$tip, {autoAlpha: 0}

LA.util.exports GuidePage 
module.exports = GuidePage 