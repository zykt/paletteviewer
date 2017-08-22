import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import "models"
import "views"
import "modules/helpers.js" as Helpers

Window {
    visible: true
    width: 480
    height: 640
    title: qsTr("Palette Viewer")

    PaletteModel {
        id: pm
    }

    PaletteIndexModel {
        id: pim
    }

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent

        Palette {
            paletteModel: pm
        }

        PaletteIndex {
            paletteIndexModel: pim
        }

        Text {
            text: "favourites"
        }
    }

    PageIndicator {
        id: indicator

        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Component.onCompleted: {
        var palette_json = Helpers.blockingRequest('http://www.colourlovers.com/api/palettes/random?format=json')
        var palette = JSON.parse(palette_json)[0]
        pm.fromJSObject(palette)

        var palettes_json = Helpers.blockingRequest("http://www.colourlovers.com/api/palettes/new?format=json")
        var palettes = JSON.parse(palettes_json)
        pim.fromJSObject(palettes)
    }
}
