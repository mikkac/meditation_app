import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Window {
    width: 480
    height: 800
    visible: true
    title: qsTr("Meditation App")
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    ColumnLayout {
        id: mainLayout
        width: parent.width
        height: parent.height
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Loader {
               id: viewLoader
               width: parent.width
               height: parent.height
               source: "MeditationView.qml"
            }
        }

        RowLayout {
            visible: true
            ButtonsBar {
                id: buttonsBar
                height: 50
                onMeditationClicked: function() { viewLoader.source = "MeditationView.qml" }
                onStatsClicked: function() { viewLoader.source = "StatsView.qml" }
                onSettingsClicked: function() { viewLoader.source = "SettingsView.qml" }
            }
        }
    }

}
