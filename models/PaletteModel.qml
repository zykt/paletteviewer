import QtQuick 2.0

Item {
    id: model

    property int id
    property string name
    property ListModel colors: ListModel { }

    function fromJSObject(obj) {
        model.id = obj.id
        model.name = obj.title
        for (var i in obj.colors) {
            colors.append({color: "#" + obj.colors[i]})
        }
    }
}
