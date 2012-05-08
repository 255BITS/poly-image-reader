poly-upload
===========

A cross-platform camera/image upload library for browsers, phones and tablets.

### Browsers ###
HTML5 Drag and Drop is supported.
Webcams are not currently supported, but feel free to add them and issue a pull request.

### Phones or Tablets ###
Camera or media library upload is supported.

Usage
===========

Requires jquery.  Try to use a new version.

### Installing via CDN ###

or alternatively download the .coffee file and compile it yourself.

### Using ###

After linking to the script tag, add this function:

    // The part of the document you want to drag and drop to, or turn into a camera
    // or media upload
    var $contentArea = $('.image-media-area');
    var options = {
      content: "Drag and Drop to upload" // Content to display in the drag and drop area
    };
    polyImageReader($contentArea, options, function(file, data) {
      // file is a data structure containing meta-information about the file
      // such as 'name'
      // data is base64 encoded
      doSomethingWith(data);
    });

###Previewing###

You don't need to use a phone or tablet to test how this looks.  Just use the
following url parameter:  `polyPreview`

####polyPreview options####

- tablet[LINK](LINK)
- phone[LINK](LINK)

###Styling###

Poly Reader places everything in CSS classes, so feel free to style to your hearts content.  Here
are a 

####List of CSS classes####
  *span.poly-upload-content.browser - the text string inside the html5 drag and drop area
