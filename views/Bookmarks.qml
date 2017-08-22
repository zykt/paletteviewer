import QtQuick 2.0
import "../models"
import "../modules/helpers.js" as Helpers

Rectangle {
    property BookmarksModel bookmarksModel

    color: "#DFCBAF"

    ListView {
        model: bookmarksModel.bookmarks
        spacing: 80
        anchors.fill: parent
        delegate: Palette {
            paletteModel: PaletteModel {
                id: delegatepm
            }
            Component.onCompleted: {
                Helpers.Request("http://www.colourlovers.com/api/palette/" + id + "?format=json")
                    .onSuccess(function(response) {
                        var palette = JSON.parse(response)[0]
                        delegatepm.fromJSObject(palette)
                    })
                    .send()
            }
        }
    }
}
