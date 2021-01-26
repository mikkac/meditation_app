import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import MeditationApp 1.0
import QtMultimedia 5.15

Item {
    property var model
    property var onPrepFinished

    Rectangle {
        id: meditationPrepView
        anchors.fill: parent
        color: Constants.gray

        ColumnLayout {
            id: mainLayout
            anchors.fill: parent
            Rectangle { // filler
                Layout.maximumHeight: parent.height * 1 / 10
                Layout.minimumHeight: parent.height * 1 / 10
                Layout.maximumWidth: parent.width
                Layout.minimumWidth: parent.width
                Label { text: "filler" }
            }

            Rectangle {
                Layout.maximumHeight: parent.height * 1 / 10
                Layout.minimumHeight: parent.height * 1 / 10
                Layout.maximumWidth: parent.width
                Layout.minimumWidth: parent.width
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter
                color: Constants.gray
                CustomSpinBox {
                    id: durationPicker
                    Layout.alignment: Qt.AlignHCenter
                    values: ["1 min", "3 min", "5 min", "10 min", "15 min", "20 min", "30 min", "45 min", "1 hour", "2 hours", "5 hours", "10 hours"]
                    mappedValues: [60, 180, 300, 600, 900, 1200, 1800, 2400, 3600, 7200, 18000, 36000]
                    defaultIndex: 3
                    title: "duration"
                    minusIconSource: "icons/minus.png"
                    plusIconSource: "icons/plus.png"
                }
            }
            Rectangle {
                Layout.maximumHeight: parent.height * 1 / 10
                Layout.minimumHeight: parent.height * 1 / 10
                Layout.maximumWidth: parent.width
                Layout.minimumWidth: parent.width
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter
                color: Constants.gray
                CustomSpinBox {
                    id: chimeDurationPicker
                    Layout.alignment: Qt.AlignHCenter
                    values: ["none", "1 min", "5 min", "10 min", "15 min", "halfway"]
                    mappedValues: [0, 60, 300, 600, 900, durationPicker.mappedValue / 2]
                    defaultIndex: 0
                    title: "chime interval"
                    minusIconSource: "icons/minus.png"
                    plusIconSource: "icons/plus.png"
                }
            }
            Rectangle { // filler
                Layout.maximumHeight: parent.height * 4 / 25
                Layout.minimumHeight: parent.height * 4 / 25
                Layout.maximumWidth: parent.width
                Layout.minimumWidth: parent.width
                Label { text: "chime sound" }
            }
            Rectangle { // filler
                Layout.maximumHeight: parent.height * 1 / 10
                Layout.minimumHeight: parent.height * 1 / 10
                Layout.maximumWidth: parent.width
                Layout.minimumWidth: parent.width
                Label { text: "filler" }
            }

            Rectangle {
                id: startButton
                color: Constants.gray
                Image {
                    id: startButtonIcon
                    source: "icons/play.png"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
                Layout.maximumHeight: Constants.height * 2 / 10
                Layout.minimumHeight: Constants.height * 2 / 10
                Layout.maximumWidth: Constants.height * 2 / 10
                Layout.minimumWidth: Constants.height * 2 / 10
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                SoundEffect {
                    id: playSound
                    source: "sounds/ding.wav"
                }
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: {
                        model.duration = durationPicker.mappedValue
                        model.startMeditation()
                        onPrepFinished()
                    }
                }
                states: State {
                    name: "pressed"
                    when: mouseArea.pressed
                    PropertyChanges {
                        target: startButtonIcon
                        scale: 1.2
                    }
                }
                transitions: Transition {
                    NumberAnimation {
                        properties: "scale"
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }
            }

        }
    }
}
