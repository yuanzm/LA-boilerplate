{$, log} = LA.util
core = LA.core

# require module setting
Slide = require "../lib/slides/easy-slide/easy-slide.coffee"
SamplePage = require "./pages/sample/sample.coffee"

# url config 
libUrl = '../assets/lib'

keys = $("#main-script")[0].src.split("/")
keys.pop()
root = keys.join "/"
pagesUrl = root + '/../assets/pages'
assetsUrl =  root + '/../assets/'

LA.set 'assetsUrl', assetsUrl
LA.set 'pagesUrl', pagesUrl
LA.set 'libUrl', libUrl

pages = [{}, {}, {}, {}, {}]

initApp = ->
  for page in pages
    core.addPage (new SamplePage page)
  core.setSlide new Slide

initApp()
