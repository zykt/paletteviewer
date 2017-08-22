import QtQuick 2.0

Rectangle {
    property var paletteModel
    anchors.fill: parent
    Column {
        Text {
            text: paletteModel.name
        }

        Row {
            Repeater {
                model: paletteModel.colors
                delegate: Rectangle {
                    width: 30
                    height: 30
                    color: modelData
                }
            }
        }
    }
}