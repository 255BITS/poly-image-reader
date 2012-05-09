# Returns a FileReader event listener that calls callback with file, and the base64 encoded file data
loadFile = (file, callback) ->
  (event) ->
    data = event.target.result
    callback(file, data)

# Binds drag/drop functionality to the passed in div
setUpListener = ($div, callback) ->
  $div.bind "dragover", (evt) ->
    evt.stopPropagation()
    evt.preventDefault()
    
  $div.bind "drop", (evt) ->
    evt.stopPropagation()
    evt.preventDefault()

    files = evt.originalEvent.dataTransfer.files

    for file in files
      unless file.type.match('image.*')
        continue

      reader = new FileReader()

      reader.onload = loadFile(file, callback)
      reader.readAsDataURL(file)

determinePlatform = (platform) ->
  href = window.location.href
  if platform == 'mobile' || (href.indexOf('polyPreview=tablet') != -1) || (href.indexOf('polyPreview=phone') != -1)
    return 'mobile'
  if platform == 'browser' || (href.indexOf('polyPreview=browser') != -1)
    return 'browser'

  if FileReader?
    return 'browser'
  if navigator?.camera
    return 'mobile'
  

#  Creates a variety of different html5 image media reader depending on platform with one function call.
#  Platform        |      Functionality
#  ------------------------------------
#  Browser(HTML5)  |      Drag & Drop using the FileReader API(no webcam yet)
#  Mobile          |      Camera or media Library
#
#  options = {
#    browserSelector : css3 selector that shows when platform is 'browser',
#    mobileSelector : css3 selector that shows when platform is 'mobile',
#    platform : Force a platform.  Can be either 'phone' or 'mobile'.  Useful for debugging.
#  }
window.polyImageReader = ($div, options, callback) ->
  options = options || {}
  browserSelector = options.browserSelector || ".browser"
  mobileSelector = options.mobileSelector || ".mobile"
  platform = determinePlatform(options.platform)

  $div.find(browserSelector).hide()
  $div.find(mobileSelector).hide()
  if platform == 'browser'
    $div.find(browserSelector).show()
    setUpListener($div, callback)

  else if platform == 'mobile'
    $div.find(mobileSelector).show()
    setUpMobile($div, callback)
