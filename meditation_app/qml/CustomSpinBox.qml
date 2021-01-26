import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Item {
    property var values: []
    property var mappedValues: []
    property var defaultIndex: 0
    property var mappedValue: mappedValues[_currentIndex]

    property var title
    property var minusIconSource
    property var plusIconSource

    property var _currentIndex: defaultIndex
    function pickNextValue() {
        if ((_currentIndex + 1)>= values.length - 1)
        {
            _currentIndex = values.length - 1
            mappedValue = mappedValues[_currentIndex]
            plusButtonDisabledAnimation.running = true
            plusButton.enabled = false
            return
        }
        if(_currentIndex === 0) {
            minusButtonEnabledAnimation.running = true
            minusButton.enabled = true
        }

        _currentIndex = _currentIndex + 1
        mappedValue = mappedValues[_currentIndex]
    }

    function pickPreviousValue() {
        if ((_currentIndex - 1) <= 0)
        {
            _currentIndex = 0
            mappedValue = mappedValues[_currentIndex]
            minusButtonDisabledAnimation.running = true
            minusButton.enabled = false
            return
        }
        if(_currentIndex === values.length - 1) {
            plusButtonEnabledAnimation.running = true
            plusButton.enabled = true
        }
        _currentIndex = _currentIndex - 1
        mappedValue = mappedValues[_currentIndex]

    }
    Component.onCompleted: {
        if (_currentIndex === 0) {
            minusButton.enabled = false
            minusButton.opacity = 0
        }
        else if (_currentIndex === values.length - 1) {
            plusButton.enabled = false
            plusButton.opacity = 0
        }
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
            width: parent.width * 0.5 / 16
            height: parent.height
            color: Constants.gray
        }
        Rectangle {
            color: Constants.gray
            width: parent.width * 7.5/ 16
            height: parent.height
            Label {
                id: titleLabel
                anchors.fill: parent
                text: title
                verticalAlignment:Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.family: loadedFont.name
                font.pointSize: 18
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
    PropertyAnimation {
        id: plusButtonEnabledAnimation
        targets: plusButton
        property: "opacity"
        to: 1.0
        duration: 500
    }
    PropertyAnimation {
        id: plusButtonDisabledAnimation
        targets: plusButton
        property: "opacity"
        to: 0.0
        duration: 500
    }
    PropertyAnimation {
        id: minusButtonEnabledAnimation
        targets: minusButton
        property: "opacity"
        to: 1.0
        duration: 500
    }
    PropertyAnimation {
        id: minusButtonDisabledAnimation
        targets: minusButton
        property: "opacity"
        to: 0.0
        duration: 500
    }
}
