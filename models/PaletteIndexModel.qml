import QtQuick 2.0

Item {
    id: model

    property ListModel palettes: ListModel { }

    function fromJSObject(obj) {
        var palette
        for (var i in obj) {
            palette = Qt.createComponent("PaletteModel.qml").createObject(null)
            palette.fromJSObject(obj[i])
            palettes.append({ palette: palette })
        }
    }
}
