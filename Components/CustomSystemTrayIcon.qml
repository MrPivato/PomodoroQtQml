import QtQuick 2.0
import Qt.labs.platform 1.1
import QtQuick.Window 2.3

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
        visible: true
        icon.source: "qrc:/Resources/app_icon.png"
        onActivated: {
            switch (window.visibility) {
            case Window.Windowed:
            case Window.FullScreen:
            case Window.Maximized:
                window.hide();
                break;
            case Window.Minimized:
            case Window.Hidden:
                window.show();
                window.raise();
                window.requestActivate();
                break;
            default:
                window.show();
                break;
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
