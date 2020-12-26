import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    property var model
    Rectangle {
        id: meditationView
        anchors.fill: parent
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
                    onClicked: model.startMeditation()
                }
                RoundButton {
                    id: pauseButton
                    text: "\u23F8"
                    onClicked: model.pauseMeditation()
                }
                RoundButton {
                    id: stopButton
                    text: "\u23F9"
                    onClicked: model.stopMeditation()
                }
            }
        }
    }

    Connections {
        target: model
        function onTimeLeftChanged(timeLeft) {
            console.log("time left: ", timeLeft)
            timeLabel.text = timeLeft }
    }
}
