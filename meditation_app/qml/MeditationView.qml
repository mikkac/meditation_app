import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import MeditationApp 1.0

Item {
    property var model
    Rectangle {
        id: meditationView
        anchors.fill: parent
        color: Constants.gray
        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            Text {
                id: timeLabel
                text: "00:00"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: Constants.height / 6
                Layout.minimumHeight: Constants.height / 6
                font.weight: Font.ExtraLight
                font.pointSize: 40
                font.family: "Arial"
                color: Constants.textColor
            }
            Button {
                id: startPauseButton
                background: Rectangle {
                    color: Constants.gray
                }
                Image {
                    id: startPauseButtonIcon
                    source: "icons/play.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    Component.onCompleted: {
                        if (model.state === MeditationState.Started) {
                            source = "icons/pause.png"
                        }
                        else if (model.state === MeditationState.Paused || model.state === MeditationState.Stopped) {
                            source = "icons/play.png"
                        }
                    }
                }
                Layout.maximumHeight: Constants.height / 4
                Layout.minimumHeight: Constants.height / 4
                Layout.maximumWidth: Constants.height / 4
                Layout.minimumWidth: Constants.height / 4
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: {
                    if (model.state === MeditationState.Started) {
                        model.pauseMeditation()
                        startPauseButtonIcon.source = "icons/play.png"
                    }
                    else if (model.state === MeditationState.Paused || model.state === MeditationState.Stopped) {
                        model.startMeditation()
                        startPauseButtonIcon.source = "icons/pause.png"
                    }
                }

            }
            Button {
                id: stopButton
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: Constants.height / 8
                Layout.minimumHeight: Constants.height / 8
                Layout.maximumWidth: Constants.height / 8
                Layout.minimumWidth: Constants.height / 8
                Layout.fillHeight: true
                background: Rectangle {
                    color: Constants.gray
                }
                Image {
                    id: stopButtonIcon
                    source: "icons/stop.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
                transformOrigin: Item.Center
                onClicked: {
                    startPauseButtonIcon.source = "icons/play.png"
                    model.stopMeditation()
                }
                enabled: model.state === MeditationState.Paused
                onEnabledChanged: {
                    if(enabled) {
                        stopButtonIcon.source = "icons/stop.png"

                    }
                    else {
                        stopButtonIcon.source = ""
                    }
                }
            }
        }
    }
    Connections {
        target: model
        function onTimeLeftChanged(timeLeftFormatted) {
            console.log("time left: ", timeLeftFormatted)
            timeLabel.text = timeLeftFormatted
        }
    }
}
