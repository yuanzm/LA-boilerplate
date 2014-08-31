{$, log} = LA.util
core = LA.core

# require module setting
Slide = require "../lib/slides/fancy-slide/fancy-slide.coffee"
SamplePage = require "./pages/sample/sample.coffee"

# url config 
pagesUrl = '../assets/pages'
libUrl = '../assets/lib'

LA.set 'pagesUrl', pagesUrl
LA.set 'libUrl', libUrl

pages = [{}, {}, {}]

initApp = ->
  for page in pages
    core.addPage (new SamplePage page)
  core.setSlide new Slide

initApp()
