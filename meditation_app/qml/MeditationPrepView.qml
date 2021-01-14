import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import MeditationApp 1.0

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
            Button {
                id: startMeditation
                width: parent.width
                Layout.maximumHeight: Constants.height / 4
                Layout.minimumHeight: Constants.height / 4
                Layout.maximumWidth: Constants.height / 4
                Layout.minimumWidth: Constants.height / 4
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "Start meditation"
                onClicked: {
                    model.duration = durationPicker.mappedItem
                    model.startMeditation()
                    onPrepFinished()
                }
            }
            SpinBox {
                id: durationPicker
                from: 0
                to: items.length - 1
                value: 3 // "10 min"

                property var items: ["1 min", "3 min", "5 min", "10 min", "15 min", "20 min", "30 min", "45 min", "1 hour", "2 hours", "5 hours", "10 hours"]
                property var itemsMapping: [60, 180, 300, 600, 900, 1200, 1800, 2700, 3600, 7200, 18000, 36000]
                property int mappedItem: itemsMapping[value]

                textFromValue: function(value) {
                    return items[value];
                }

                valueFromText: function(text) {
                    for (var i = 0; i < items.length; ++i) {
                        if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                            return i
                    }
                    return sb.value
                }

                onValueModified: mappedItem = itemsMapping[value]
            }
        }
    }
}
