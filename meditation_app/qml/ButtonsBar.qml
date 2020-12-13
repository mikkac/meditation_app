import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

RowLayout {
    property var onMeditationClicked
    property var onStatsClicked
    property var onSettingsClicked

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignVCenter | Qt.AlignBottom

    RoundButton {
        id: meditationButton
        text: "meditate"
        height: parent.height
        Layout.fillWidth: true
        visible: true
        onClicked: onMeditationClicked()
    }

    RoundButton {
        id: statsButton
        text: "stats"
        height: parent.height
        Layout.fillWidth: true
        visible: true
        onClicked: onStatsClicked()
    }

    RoundButton {
        id: settingsButton
        text: "settings"
        height: parent.height
        Layout.fillWidth: true
        visible: true

        onClicked: onSettingsClicked()
    }
}
