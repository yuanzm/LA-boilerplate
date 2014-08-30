{$, log} = LA.util
core = LA.core

# require module setting
Slide = require "../lib/slides/fancy-slide/fancy-slide.coffee"
Loading = require "../lib/loadings/simple-loading/loading.coffee"
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
  core.setLoading new Loading
  core.setSlide new Slide

initApp()
