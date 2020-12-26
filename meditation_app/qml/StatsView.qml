import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property var model
    Rectangle {
        id: settingsWindow
        Row {
            Text {
                text: "STATS WINDOW"
                y: 50
            }
        }
    }
}
