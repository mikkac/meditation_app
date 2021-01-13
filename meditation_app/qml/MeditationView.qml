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
            Rectangle {
                id: startPauseButton
                color: Constants.gray
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
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (model.state === MeditationState.Started) {
                            model.pauseMeditation()
                            startPauseButtonIcon.source = "icons/play.png"
                            stopButtonEnabledAnimation.running = true
                            stopButton.enabled = true
                        }
                        else if (model.state === MeditationState.Paused || model.state === MeditationState.Stopped) {
                            model.startMeditation()
                            startPauseButtonIcon.source = "icons/pause.png"
                            stopButtonDisabledAnimation.running = true
                            stopButton.enabled = false
                        }
                    }
                }
                states: State {
                    name: "pressed"
                    when: mouseArea.pressed
                    PropertyChanges { target: startPauseButtonIcon; scale: 1.2 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 300; easing.type: Easing.InOutQuad }
                }
            }
            Rectangle {
                id: stopButton
                color: Constants.gray
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: Constants.height / 8
                Layout.minimumHeight: Constants.height / 8
                Layout.maximumWidth: Constants.height / 8
                Layout.minimumWidth: Constants.height / 8
                Layout.fillHeight: true
                Image {
                    id: stopButtonIcon
                    source: "icons/stop.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
                transformOrigin: Item.Center
                enabled: false
                onEnabledChanged: {
                    if(enabled) {
                        stopButtonIcon.source = "icons/stop.png"

                    }
                    else {
                        stopButtonIcon.source = ""
                    }
                }
                MouseArea {
                    id: stopButtonArea
                    anchors.fill: parent
                    onClicked: {
                        startPauseButtonIcon.source = "icons/play.png"
                        model.stopMeditation()
                        stopButtonDisabledAnimation.running = true
                    }
                }
                states: State {
                    name: "pressed"
                    when: stopButtonArea.pressed
                    PropertyChanges { target: stopButtonIcon; scale: 1.2}
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
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
    PropertyAnimation {
        id: stopButtonEnabledAnimation
        targets: stopButton
        property: "opacity"
        to: 1.0
        duration: 500
    }
    PropertyAnimation {
        id: stopButtonDisabledAnimation
        targets: stopButton
        property: "opacity"
        to: 0.0
        duration: 500
    }
}
