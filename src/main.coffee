{$, log} = LA.util
core = LA.core

# require module setting
Slide = require "../lib/slides/easy-slide/easy-slide.coffee"
page1 = require "./pages/page1/page1.coffee"
page2 = require "./pages/page2/page2.coffee"
page3 = require "./pages/page3/page3.coffee"
page4 = require "./pages/page4/page4.coffee"
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

pages = [{}, {}, {}, {}]

initApp = ->
  core.addPage (new page1)
  core.addPage (new page2)
  core.addPage (new page3)
  core.addPage (new page4)
  core.setSlide new Slide

initApp()
