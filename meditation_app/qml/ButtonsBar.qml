import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

RowLayout {
    id: mainLayout
    property var onMeditationClicked
    property var onStatsClicked
    property var onSettingsClicked
    property var iconsEnabled: true

    property var meditationViewActive: true
    property var statsViewActive: false
    property var settingsViewActive: false

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter | Qt.AlignBottom

    Rectangle {
        id: meditationButton
        color: Constants.gray
        width: Constants.width / 3
        Layout.maximumHeight: parent.height
        Layout.maximumWidth: Constants.width / 3
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Image {
            id: meditationButtonIcon
            source: "icons/meditation.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            id: meditationButtonArea
            anchors.fill: parent
            onClicked: {
                onMeditationClicked()
                meditationViewActive = true
                statsViewActive = false
                settingsViewActive = false
            }
        }
        states: State {
            name: "pressed"
            when: meditationButtonArea.pressed && !meditationViewActive
            PropertyChanges {
                target: meditationButton
                scale: 1.2
            }
        }
        transitions: Transition {
            NumberAnimation {
                property: "scale"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    }
    Rectangle {
        id: statsButton
        color: Constants.gray
        width: Constants.width / 3
        Layout.maximumHeight: parent.height
        Layout.maximumWidth: Constants.width / 3
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Image {
            id: statsButtonIcon
            source: "icons/stats.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            id: statsButtonArea
            anchors.fill: parent
            onClicked: {
                onStatsClicked()
                meditationViewActive = false
                statsViewActive = true
                settingsViewActive = false
            }
        }
        states: State {
            name: "pressed"
            when: statsButtonArea.pressed
            PropertyChanges {
                target: statsButtonIcon
                scale: 1.2
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    }
    Rectangle {
        id: settingsButton
        color: Constants.gray
        width: Constants.width / 3
        Layout.maximumHeight: parent.height
        Layout.maximumWidth: Constants.width / 3
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Image {
            id: settingsButtonIcon
            source: "icons/settings.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        MouseArea {
            id: settingsButtonArea
            anchors.fill: parent
            onClicked: {
                onSettingsClicked()
                meditationViewActive = false
                statsViewActive = false
                settingsViewActive = true
            }
        }
        states: State {
            name: "pressed"
            when: settingsButtonArea.pressed
            PropertyChanges {
                target: settingsButtonIcon
                scale: 1.2
            }
        }
        transitions: Transition {
            NumberAnimation {
                properties: "scale"
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    }
    PropertyAnimation {
        id: buttonsDisabledAnimation
        targets: [meditationButton, statsButton, settingsButton]
        property: "opacity"
        to: 0.0
        duration: 500
    }
    PropertyAnimation {
        id: buttonsEnabledAnimation
        targets: [meditationButton, statsButton, settingsButton]
        property: "opacity"
        to: 1.0
        duration: 500
    }
    onIconsEnabledChanged: {
        if (iconsEnabled) {
            buttonsEnabledAnimation.running = true
            mainLayout.enabled = true
        } else {
            buttonsDisabledAnimation.running = true
            mainLayout.enabled = false
        }
    }
}
