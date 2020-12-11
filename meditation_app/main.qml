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
            Loader {
               id: viewLoader
               source: "main_view.qml"
               anchors.fill: parent
            }
        }
        RowLayout {
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom

            RoundButton {
                id: meditationButton
                height: parent.height
                visible: true
                onClicked: viewLoader.source = "main_view.qml"
            }

            RoundButton {
                id: statsButton
                height: parent.height
                visible: true
                onClicked: viewLoader.source = "stats_view.qml"
            }

            RoundButton {
                id: settingsButton
                height: parent.height
                visible: true

                onClicked: viewLoader.source = "settings_view.qml"
            }
        }
    }
}
