import QtQuick 2.0
import QtQuick.Controls 2.15
Item {
    id: loadingScreenView

    Frame {
        id: loadingFrame
        anchors.fill: parent

        BusyIndicator {
            id: busyIndicator
            running: true
            width: parent.width * (5/10)
            height: parent.height * (5/10)
            anchors.centerIn: parent
        }
    }
}
