import QtQuick 2.0
import QtQuick.Controls 2.15

import "../Components"

Item {
    id: settingsView

    readonly property string mSettingsBkgColor: "#f9f9f9"

    Rectangle {
        id: settingsContainer
        color: mSettingsBkgColor
        anchors.fill: parent
        radius: 20

        ScrollView {
            id: scrollContainer
            ScrollBar.horizontal.interactive: false
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            clip: true
            anchors {
                fill: parent
                margins: settingsContainer.radius * (5/10)
            }

            Label {
                id: timerTitle
                text: "Timer Settings"
                font.pixelSize: 24
                anchors {
                    top: parent.top
                }
            }

            Frame {
                id: inputsFrame
                height: parent.height * (5/10)
                anchors{
                    left: parent.left
                    right: parent.right
                    top: timerTitle.bottom
                    topMargin: 10
                }

                Label {
                    id: inputsTitle
                    text: "Time (Minutes)"
                    font.pixelSize: 18
                    anchors {
                        left: parent.left
                        top: parent.top
                    }
                }

                CustomDial {
                    id: pomodoroTimerInput
                    width: shortBreakTimerInput.width
                    height: shortBreakTimerInput.height
                    anchors {
                        top: shortBreakTimerInput.top
                        right: shortBreakTimerInput.left
                        rightMargin: parent.width * (1/10)
                    }

                    mDialInputValue: TimerClass.pomodoroTime.toLocaleString(Qt.locale("en_US"), "mm")
                    mDialTimerLabel: "Pomodoro"
                    onMDialInputValueChanged: TimerClass.setPomodoroTime(mDialInputValue)
                }

                CustomDial {
                    id: shortBreakTimerInput
                    width: parent.width * (20/100)
                    height: parent.height * (7/10)
                    anchors {
                        top: inputsTitle.bottom
                        horizontalCenter: parent.horizontalCenter
                    }

                    mDialInputValue: TimerClass.shortBreakTime.toLocaleString(Qt.locale("en_US"), "mm")
                    mDialTimerLabel: "Short Break"
                    onMDialInputValueChanged: TimerClass.setShortBreakTime(mDialInputValue)
                }

                CustomDial {
                    id: longBreakTimerInput
                    width: shortBreakTimerInput.width
                    height: shortBreakTimerInput.height
                    anchors {
                        top: shortBreakTimerInput.top
                        left: shortBreakTimerInput.right
                        leftMargin: pomodoroTimerInput.anchors.rightMargin
                    }

                    mDialInputValue: TimerClass.longBreakTime.toLocaleString(Qt.locale("en_US"), "mm")
                    mDialTimerLabel: "Long Break"
                    onMDialInputValueChanged: TimerClass.setLongBreakTime(mDialInputValue)
                }
            }

            Button {
                id: saveSettingsButton
                text: "Save"
                font.pointSize: 18
                font.bold: true
                width: parent.width * (3/10)
                height: parent.height * (1/10)
                anchors {
                    horizontalCenter: inputsFrame.horizontalCenter
                    top: inputsFrame.bottom
                    topMargin: 10
                }

                onClicked: {
                    TimerClass.writeSettings();
                }
            }
        }
    }
}
