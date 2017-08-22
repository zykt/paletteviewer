import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property ListModel bookmarks: ListModel { }


    function addBokmark(id) {
        try {
            var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
            db.transaction(function(tx) {
                var result = tx.executeSql("INSERT INTO bookmarks values (?)", [id])
            })
            console.log("Bookmark added")
        } catch (err) {
            console.error("Error adding bookmark: " + err)
        }
    }

    function checkBookmark(id) {
        // check if bookmark already exists
        try {
            console.log("Opening db")
            var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
            var check
            db.readTransaction(function(tx) {
                console.log("Sql select * where id=" + id)
                var result = tx.executeSql("SELECT * FROM bookmarks where id=?", [id])
                if (result.rows.length > 0) {
                    check = true
                } else {
                    check = false
                }
            })
            console.log("Bookmark checked: " + check)
            return check
        } catch (err) {
            console.error("Error checking bookmark: " + err)
        }
    }

    function deleteBookmark(id) {
        try {
            console.log("Opening db")
            var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
            db.transaction(function(tx) {
                console.log("Sql delete where id=" + id)
                var result = tx.executeSql("DELETE FROM bookmarks where id=?", [id])
            })
            console.log("Bookmark deleted: " + id)
        } catch (err) {
            console.error("Error deleting bookmark: " + err)
        }
    }

    function refreshBookmarks() {
        // load bookmarks into model
        try {
            console.log("Opening db")
            var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
            db.readTransaction(function(tx) {
                console.log("Sql select")
                var result = tx.executeSql("SELECT * FROM bookmarks")
                bookmarks.clear()
                for (var i=0; i < result.rows.length; i++) {
                    bookmarks.append({ id: result.rows.item(i).id })
                }
            })
            console.log("Bookmarks loaded")
        } catch (err) {
            console.error("Error getting bookmarks: " + err)
        }
    }

    function init() {
        var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
        try {
            db.transaction(function(tx) {
                tx.executeSql("CREATE TABLE IF NOT EXISTS bookmarks (id INT UNIQUE)")
            })
            console.log("Database inited")
        } catch (err) {
            console.error("Error creating table: " + err)
        }
    }

    function dropBookmarks() {
        // drop table if something went wrong
        try {
            var db = LocalStorage.openDatabaseSync("bookmarksDB", "0.1", "DB for bookmarks", 500)
            db.transaction(function(tx) {
                var result = tx.executeSql("DROP TABLE bookmarks")
            })
            console.log("TABLE DROPPED")
        } catch (err) {
            console.error("Error dropping: " + err)
        }
    }

    Component.onCompleted: {
        // create/load table then load bookmarks into model
        init()
        refreshBookmarks()
    }
}
