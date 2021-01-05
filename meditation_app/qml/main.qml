import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import QtQuick.Controls 2.15
import MeditationApp 1.0

ApplicationWindow {
    width: Constants.width
    height: Constants.height
    visible: true
    title: qsTr("Meditation App")
    Material.theme: Material.Dark
    Material.accent: Material.Purple

    footer: ToolBar {
        ButtonsBar {
            id: buttonsBar
            anchors.fill: parent
            onMeditationClicked: function() {
                if (viewLoader.source != Qt.resolvedUrl("MeditationView.qml"))
                {
                    viewLoader.setSource("MeditationView.qml", {"model": meditationModel})
                }
            }
            onStatsClicked: function() { viewLoader.source = "StatsView.qml" }
            onSettingsClicked: function() { viewLoader.source = "SettingsView.qml" }
        }
    }

    ColumnLayout {
        id: mainLayout
        width: parent.width
        height: parent.height
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Item {

                width: parent.width
                height: parent.height
                Loader {
                   id: viewLoader
                   width: parent.width
                   height: parent.height
                   onSourceChanged: animation.running = true
                }

                NumberAnimation {
                    id: animation
                    target: viewLoader.item
                    property: "y"
                    from: viewLoader.item.height
                    to: 0
                    duration: 300
                    easing.type: Easing.InExpo
                }

                Component.onCompleted:  {
                    viewLoader.setSource("MeditationView.qml", {"model": meditationModel})
                }
            }
        }
    }

}
