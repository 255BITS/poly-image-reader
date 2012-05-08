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

    console.log files
    for file in files
      unless file.type.match('image.*')
        console.log "ignoring file of type #{file.type}"
        continue

      reader = new FileReader()

      reader.onload = loadFile(file, callback)
      reader.readAsDataURL(file)


#  Creates a variety of different html5 image media reader depending on platform with one function call.
#  Platform        |      Functionality
#  ------------------------------------
#  Browser(HTML5)  |      Drag & Drop using the FileReader API(no webcam yet)
#  Tablet          |      Camera or media Library
#  Phone           |      Camera or media Library
#
#  Options contains:
#  content - browser content to display inside of an inner span
window.polyImageReader = ($div, options, callback) ->
  options = options || {}
  content = options.content || "Drag and drop an image here"
  $span = $("<span class='poly-upload-content browser'/>")
  $span.html(content)
  $div.html($span)
  setUpListener($div, callback)
