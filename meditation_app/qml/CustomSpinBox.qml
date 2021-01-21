import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    property var values: []
    property var mappedValues: []
    property var defaultIndex
    property var mappedValue: mappedValues[_currentIndex]

    property var title
    property var minusIconSource
    property var plusIconSource

    property var _currentIndex: 0
    function pickNextValue() {
        if ((_currentIndex + 1)>= values.length - 1)
        {
            _currentIndex = values.length - 1
            mappedValue = mappedValues[_currentIndex]
            return
        }
        _currentIndex = _currentIndex + 1
        mappedValue = mappedValues[_currentIndex]
    }

    function pickPreviousValue() {
        if ((_currentIndex - 1) <= 0)
        {
            _currentIndex = 0
            mappedValue = mappedValues[_currentIndex]
            return
        }
        _currentIndex = _currentIndex - 1
        mappedValue = mappedValues[_currentIndex]

    }
    FontLoader {
        id: loadedFont
        source: "fonts/blue_highway.ttf"
    }

    anchors.fill: parent
    Row
    {
        id: spinBoxLayout
        anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter
        spacing: parent.width / 30
        Rectangle {
            color: Constants.gray
            width: parent.width * 8/ 16
            height: parent.height
            Label {
                id: titleLabel
                anchors.fill: parent
                text: title
                verticalAlignment:Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: loadedFont.name
                font.pointSize: 20
                color: Constants.textColor
            }
        }

        Rectangle {
            id: minusButton
            color: Constants.gray
            width: parent.width / 16
            height: parent.height
            Image {
                id: minusButtonIcon
                source: minusIconSource
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
            MouseArea {
                id: minusButtonArea
                anchors.fill: parent
                onClicked: pickPreviousValue()
            }
            states: State {
                name: "pressed"
                when: minusButtonArea.pressed
                PropertyChanges {
                    target: minusButtonIcon
                    scale: 1.7
                }
            }
            transitions: Transition {
                NumberAnimation {
                    properties: "scale"
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Rectangle {
            width: parent.width * 3 / 16
            height: parent.height
            color: Constants.gray
            Label {
                id: spinBoxValue
                text: values[_currentIndex]

                anchors.fill: parent
                verticalAlignment:Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: loadedFont.name
                font.pointSize: 15
                color: Constants.textColor

            }
        }
        Rectangle {
            id: plusButton
            color: Constants.gray
            Image {
                id: plusButtonIcon
                source: plusIconSource
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
            width: parent.width / 16
            height: parent.height
            MouseArea {
                id: plusButtonArea
                anchors.fill: parent
                onClicked: pickNextValue()
            }
            states: State {
                name: "pressed"
                when: plusButtonArea.pressed
                PropertyChanges {
                    target: plusButtonIcon
                    scale: 1.7
                }
            }
            transitions: Transition {
                NumberAnimation {
                    properties: "scale"
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Rectangle {
            width: parent.width * 3 / 16
            height: parent.height
            color: Constants.gray
        }
    }
}
