import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {
    id: meditationView
    color: "gray"
    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        Label {
            id: timeLabel
            Layout.alignment: Qt.AlignCenter
            text: "25:00"
        }
        Row {
            Layout.alignment: Qt.AlignCenter
            id: buttonsRow
            RoundButton {
                id: startButton
                text: "\u25B6"
            }
            RoundButton {
                id: pauseButton
                text: "\u23F8"
            }
            RoundButton {
                id: stopButton
                text: "\u23F9"
            }
        }
    }
}
