import QtQuick 2.0
import QtQuick.Controls 2.15
import MeditationApp 1.0

Item {
    property var model
    property var onPrepFinished

    Rectangle {
        id: meditationPrepView
        anchors.fill: parent
        color: Constants.gray
        Button {
            id: startMeditation
            width: parent.width
            text: "Start meditation"
            onClicked: {
                model.startMeditation()
                onPrepFinished()
            }
        }
    }
}
