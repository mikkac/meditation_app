import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Window {
    width: 480
    height: 800
    visible: true
    title: qsTr("Meditation App")

    ColumnLayout {
        id: mainLayout
        width: parent.width
        height: parent.height
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Loader {
               id: viewLoader
               source: "MeditationView.qml"
            }
        }

        RowLayout {
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
