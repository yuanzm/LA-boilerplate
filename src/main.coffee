{$, log} = LA.util
core = LA.core

# require module setting
Slide = require "../lib/slides/simple-slide/slide.coffee"
Loading = require "../lib/loadings/simple-loading/loading.coffee"
Cover = require "../lib/covers/simple-cover/cover.coffee"

IntroducePage = require "./pages/introduce/introduce.coffee"
TextPage = require "./pages/text/text.coffee"
EndPage = require "./pages/end/end.coffee"

# url config 
LA.set 'pagesUrl', '../assets/pages'
LA.set 'libUrl', '../assets/lib'

run = ->

  core.setLoading new Loading
  core.setCover new Cover 

  core.addPage new IntroducePage {name:'introduce'}
  core.addPage new TextPage {name:'text page'}
  core.addPage new EndPage {name:'end page'}

  core.setSlide new Slide


run()
