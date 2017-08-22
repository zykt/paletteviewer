import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    property var paletteModel

    signal bookmark(int id)

    color: "#EEEEEE"

    Column {
        Row {
            spacing: 5
            Text {
                text: paletteModel.name
            }
            Button {
                width: 20
                height: 20
                text: "★"
                onClicked: {
                    bookmark(paletteModel.id)
                    console.log("Bookmark clicked: " + paletteModel.id)
                }
            }
        }
        Row {
            spacing: 5
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
