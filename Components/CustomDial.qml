import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: customDialComponent

    property int mDialInputValue: 1
    property string mDialTimerLabel: "FILL-ME"

    Dial {
        id: dialInput
        anchors.fill: parent

        value: mDialInputValue
        onValueChanged: mDialInputValue = value

        snapMode: Dial.SnapAlways
        from: 1
        to: 55
        stepSize: 1
        wheelEnabled: true

        Label {
            id: dialValueLabel
            text: mDialInputValue
            font.bold: true
            font.pointSize: 16
            anchors.centerIn: parent
        }

        Label {
            id: dialTimerLabel
            text: mDialTimerLabel
            font.pointSize: 12
            font.bold: true
            anchors {
                top: dialInput.bottom
                horizontalCenter: dialInput.horizontalCenter
            }
        }
    }
}
