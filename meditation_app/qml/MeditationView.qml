import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import MeditationApp 1.0

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
                text: model.timeLeftS
            }
//            ColumnLayout {
//                Layout.alignment: Qt.AlignCenter
//                id: buttonsRow
                RoundButton {
                    id: startPauseButton
                    Layout.alignment: Qt.AlignCenter
                    text: "\u25B6"
                    height: 200
                    width: 200
                    onClicked: {
                        console.log(model.state)
                        if (model.state === MeditationState.Started)
                        {
                            model.pauseMeditation()
                            text = "\u25B6"
                        }
                        else if (model.state === MeditationState.Paused || model.state === MeditationState.Stopped)
                        {
                            model.startMeditation()
                            text = "\u23F8"
                        }
                    }
                }
                RoundButton {
                    id: stopButton
                    Layout.alignment: Qt.AlignCenter
                    text: "\u23F9"
                    onClicked:
                    {
                        startPauseButton.text = "\u25B6"
                        model.stopMeditation()
                    }
                    visible: model.state === MeditationState.Paused
                }
//            }
        }
    }

    Connections {
        target: model
        function onTimeLeftChanged(timeLeft) {
            console.log("time left: ", timeLeft)
            timeLabel.text = timeLeft }
    }
}
