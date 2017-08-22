import QtQuick 2.0
import "../models"

Rectangle {
    property PaletteIndexModel paletteIndexModel

    color: "#B0C2DC"
    ListView {
        anchors.fill: parent
        spacing: 80
        model: paletteIndexModel.palettes
        delegate: Palette {
            paletteModel: palette
        }
    }
}
