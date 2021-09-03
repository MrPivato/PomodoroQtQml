import QtQuick 2.15
import QtQuick.Window 2.15

import "Views"
import "Components"

Window {
    id: window
    width: 640
    height: 480

    minimumWidth: 640
    minimumHeight: 480

    visible: true
    title: qsTr("Pomodoro")

    property string pomodoroBkgColor: "#a0d911" //lime-6
    property string pomodoroTimerChooserColor: "#7cb305" //lime-7
    property string pomodoroClockFaceColor: "#bae637" //lime-5
    property string pomodoroTextColor: "#ffffff" //white
    //    property string pomodoroBtnBkg: "#f7f7f7" // unused?

    property string shortBreakBkgColor: "#2f54eb"
    property string shortBreakTimerChooserColor: "#1d39c4"
    property string shortBreakClockFaceColor: "#597ef7"
    property string shortBreakTextColor: "#ffffff"
    //    property string shortBreakBtnBkg: "#f7f7f7"

    property string longBreakBkgColor: "#faad14"
    property string longBreakTimerChooserColor: "#d48806"
    property string longBreakClockFaceColor: "#ffc53d"
    property string longBreakTextColor: "#ffffff"
    //    property string longBreakBtnBkg: "#f7f7f7"

    property string currentBkgColor: "#bfbfbf"
    property string currentTimerChooserColor: "#8c8c8c"
    property string currentClockFaceColor: "#d9d9d9"
    property string currentTextColor: "#262626"
    //    property string currentBtnBkg: "#f7f7f7"

    function setPomodoroAsCurrentColorScheme() {
        currentBkgColor = pomodoroBkgColor;
        currentTimerChooserColor = pomodoroTimerChooserColor;
        currentClockFaceColor = pomodoroClockFaceColor;
        currentTextColor = pomodoroTextColor;
        //        currentBtnBkg = pomodoroBtnBkg;
    }

    function setShortBreakAsCurrentColorScheme() {
        currentBkgColor = shortBreakBkgColor;
        currentTimerChooserColor = shortBreakTimerChooserColor;
        currentClockFaceColor = shortBreakClockFaceColor;
        currentTextColor = shortBreakTextColor;
        //        currentBtnBkg = shortBreakBtnBkg;
    }

    function setLongBreakAsCurrentColorScheme() {
        currentBkgColor = longBreakBkgColor;
        currentTimerChooserColor = longBreakTimerChooserColor;
        currentClockFaceColor = longBreakClockFaceColor;
        currentTextColor = longBreakTextColor;
        //        currentBtnBkg = longBreakBtnBkg;
    }

    Component.onCompleted: setPomodoroAsCurrentColorScheme();

    Rectangle {
        id: uiContainer
        color: currentBkgColor
        anchors.fill: parent

        NavBar {
            id: navBar
            height: parent.height * (5/100)
            anchors {
                left: parent.left;
                right: parent.right;
                top: parent.top;
                margins: 0
            }
        }

        Loader {
            id: pageLoader
            sourceComponent: clockFaceUiComponent
            anchors.centerIn: parent
            width: parent.width * (6/10)
            height: parent.height * (7/10)
            states: [
                State {
                    name: "ClockFaceViewChoosed"
                    when: navBar.pageToLoad === "ClockFaceView"
                    PropertyChanges {
                        target: pageLoader
                        sourceComponent: clockFaceUiComponent
                    }
                },
                State {
                    name: "SettingsViewChoosed"
                    when: navBar.pageToLoad === "SettingsView"
                    PropertyChanges {
                        target: pageLoader
                        sourceComponent: settingsUiComponent
                    }
                }
            ]
        }

        Component {
            id: clockFaceUiComponent
            ClockFace {
                id: clockFaceView
                mCfcBkgColor: currentBkgColor
                mCfcTimerChooserColor: currentTimerChooserColor
                mCfcClockFaceColor: currentClockFaceColor
                mCfcTextColor: currentTextColor
                //                mCfcBtnBkg: currentBtnBkg
            }
        }

        Component {
            id: settingsUiComponent
            Settings {
                id: settingsView
            }
        }
    }

    CustomSystemTrayIcon {}

}
