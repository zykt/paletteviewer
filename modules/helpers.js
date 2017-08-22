.pragma library

function Request(url) {
    var _url = url

    var request = {
        url: _url
    }

    request.onSuccess = function(callback) {
        request._success = callback
        return request
    }

    request.send = function() {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState == XMLHttpRequest.DONE) {
                request._success(doc.responseText)
            }
        }
        doc.open("GET", url)
        doc.send()
    }

    return request
}
