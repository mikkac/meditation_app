import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

RowLayout {
    property var onMeditationClicked
    property var onStatsClicked
    property var onSettingsClicked

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter | Qt.AlignBottom

    Button {
        id: meditationButton
        Image {
            id: meditationButtonIcon
            source: Qt.resolvedUrl("icons/meditation.png")
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }

        height: parent.height
        Layout.fillWidth: true
        visible: true
        onClicked: onMeditationClicked()
        flat: true
    }

    Button {
        id: statsButton
        Image {
            id: statsButtonIcon
            source: Qt.resolvedUrl("icons/stats.png")
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        height: parent.height
        Layout.fillWidth: true
        visible: true
        onClicked: onStatsClicked()
        flat: true
    }

    Button {
        id: settingsButton
        Image {
            id: settingsButtonIcon
            source: "icons/settings.png"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        height: parent.height
        Layout.fillWidth: true
        visible: true
        onClicked: onSettingsClicked()
        flat: true
    }
}
