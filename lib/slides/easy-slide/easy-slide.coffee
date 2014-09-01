gestureEvent = require "./gesture-event.coffee"
HEIGHT = document.documentElement.clientHeight
WIDTH = document.documentElement.clientWidth
GAP = 0.3 * HEIGHT
MAX_GAP = HEIGHT * 0.8

css = ($dom, style)->
    for key, value of style
        if key is "y" then setY $dom, value
        else $dom.css key, value

setY = ($dom, y)->
    if typeof y is "string" and $dom.y
        param = if y[0] is "+" then 1 else -1
        y = $dom.y + param * (parseInt y.slice(2))
    $dom[0].style.webkitTransform = "translate3d(0, #{y}px, 0)"
    $dom.y = y

class EasySlide extends LA.SlideController
    constructor: ->
        @$progress = $ "<ul id='slide-progress'></ul>"
        @$pages = $ "div.pages"
        @$pages.css "width", "#{WIDTH}px"
        $("div.wrapper").append @$progress
        @currentIndex = 0
        @able = no
        @isLoop = yes
        @isReachEnd = no
        @isFirstSetCurr = yes
        @isProgressShow = yes
        @duration = 1
        @isAnimating = no
        @isFast = no
    init: (pages)->
        @pages = pages
        @pages.forEach (page, i)=>
            page.$container.css "height", "#{HEIGHT}px"
            page.$container.css "width", "#{WIDTH}px"
            page.pageIndex = i 
            @$progress.append ($ "<li id='progress-#{i}'></li>")
        @_setPosByIndex 0
        @_activeProgressByIndex @currentIndex
        @_initEvents()
    enable: ->
        @able = yes
    disable: ->
        @able = no
    loop: ->
        @isLoop = yes
    unloop: ->
        @isLoop = no
    showProgress: ->
        @isProgressShow = yes
        @$progress.show()
    hideProgress: ->
        @isProgressShow = no
        @$progress.hide()
    setDuration: (duration)->
        @duration = duration or @duration
    fast: ->
        @isFast = yes
    unfast: ->
        @isFast = no
    _initEvents: ->
        gestureEvent.on "swiping up", (dist)=>
            if not @able or @isAnimating then return
            if @currentIndex is @pages.length - 1
                if dist > MAX_GAP then dist = MAX_GAP
            else
                if dist > GAP then @_activeProgressByIndex @currentIndex + 1
                else if @currentActiveProgressIndex isnt @currentIndex
                    @_activeProgressByIndex @currentIndex
            setY @$pages, -@currentIndex * HEIGHT - dist
        gestureEvent.on "swipe up", (dist, v, distTime)=>
            if not @able or @isAnimating then return
            isRun = no
            currentProgress = dist / HEIGHT
            if @currentIndex isnt @pages.length - 1 and (dist > GAP or v > 1)
                @previousIndex = @currentIndex
                @currentIndex++
                isRun = yes
                duration = (1 - currentProgress) * @duration
                if @isFast and v > 2 then duration = 0.15
            else duration = 0.5
            @_enableAnimation duration
            @_setPosByIndex @currentIndex
            setTimeout =>
                @_disableAnimation()
                if isRun then @_triggerActive()
            , duration * 1.1 * 1000
        gestureEvent.on "swiping down", (dist)=>
            if not @able or @isAnimating then return
            if @currentIndex is 0
                if dist > MAX_GAP then dist = MAX_GAP
            else
                if dist > GAP then @_activeProgressByIndex @currentIndex - 1
                else if @currentActiveProgressIndex isnt @currentIndex
                    @_activeProgressByIndex @currentIndex
            setY @$pages, -@currentIndex * HEIGHT + dist
        gestureEvent.on "swipe down", (dist, v, distTime)=>
            if not @able or @isAnimating then return
            isRun = no
            currentProgress = dist / HEIGHT
            if @currentIndex isnt 0 and (dist > GAP or v > 1)
                @previousIndex = @currentIndex
                @currentIndex--
                isRun = yes
                duration = (1 - currentProgress) * @duration
                if @isFast and v > 2 then duration = 0.15
            else duration = 0.5
            @_enableAnimation duration
            @_setPosByIndex @currentIndex
            setTimeout =>
                @_disableAnimation()
                if isRun then @_triggerActive()
            , duration * 1.1 * 1000
    _triggerActive: ->
        @_activeProgressByIndex @currentIndex
        if typeof @previousIndex is "number" then @emit "deactive", @pages[@previousIndex]
        if typeof @currentIndex is "number" then @emit "active", @pages[@currentIndex]
    _setPosByIndex: (index)->
        setY @$pages, -index * HEIGHT
    _activeProgressByIndex: (index)->            
        @currentActiveProgressIndex = index
        $("#slide-progress li.active").removeClass "active"
        $("#progress-#{index}").addClass "active"
    _enableAnimation: (duration)->    
        @isAnimating = yes
        cssStr = "all #{duration}s ease-out"
        @$pages[0].style.webkitTransition = cssStr
    _disableAnimation: ->    
        @isAnimating = no
        @$pages[0].style.webkitTransition = ""

LA.util.exports EasySlide
module.exports = EasySlide
