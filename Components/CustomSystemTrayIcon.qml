import QtQuick 2.0
import Qt.labs.platform 1.1

Item {
    id: customSystemTrayIconComponent

    Connections {
        target: TimerClass
        function onTimeoutReachedTimeTo(wichTimer) {
            wichTimer = wichTimer.toUpperCase();
            if(wichTimer === pomodoroActionStr) {
                setPomodoroAsCurrentColorScheme();
                systemTrayIcon.showMessage(
                            wichTimer,
                            "Time to get some work done.");
            } else if(wichTimer === shortBreakActionStr) {
                setShortBreakAsCurrentColorScheme();
                systemTrayIcon.showMessage(
                            wichTimer,
                            "Time for a pause.");
            } else if(wichTimer === longBreakActionStr) {
                setLongBreakAsCurrentColorScheme();
                systemTrayIcon.showMessage(
                            wichTimer,
                            "Time to get some rest.");
            }
        }
    }

    SystemTrayIcon {
        id: systemTrayIcon
        property bool isWindowShown: false
        visible: true
        icon.source: "qrc:/Resources/app_icon.png"
        onActivated: {
            isWindowShown = !isWindowShown;
            if (!isWindowShown) {
                window.show();
                window.raise();
                window.requestActivate();
            } else {
                window.hide();
            }
        }
        menu: Menu {
            MenuItem {
                text: qsTr("Quit App")
                onTriggered: Qt.quit()
            }
        }
        tooltip: "Remaining Time: " + TimerClass.remainingTime.toLocaleTimeString(Qt.locale("en_US"), "mm:ss")
    }
}
