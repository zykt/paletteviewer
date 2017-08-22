import QtQuick 2.0

Item {
    id: model

    property var dummy: "wqr"
    property ListModel palettes: ListModel { }

    function fromJSObject(obj) {
        var palette
        for (var i in obj) {
            palette = Qt.createComponent("PaletteModel.qml").createObject(null)
            console.log(palette)
            palette.fromJSObject(obj[i])
            palettes.append({ palette: palette })
        }
    }
}
