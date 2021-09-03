import QtQuick 2.0
import "../Components"

Item {
    id: clockFaceView

    property string mCfcBkgColor: "#FF0000"
    property string mCfcTimerChooserColor: "#00FF00"
    property string mCfcClockFaceColor: "#0000FF"
    property string mCfcTextColor: "#AA0000"
//    property string mCfcBtnBkg: "#00AA00"

    Rectangle {
        id: clockFace
        anchors.fill: parent
        radius: 20
        color: mCfcClockFaceColor

        CustomButton {
            id: pomodoroBtn
            anchors {
                top: shortBreakBtn.top
                right: shortBreakBtn.left
                rightMargin: 10
            }
            mBtnImplicitWidth:  shortBreakBtn.mBtnImplicitWidth
            mBtnImplicitHeight: shortBreakBtn.mBtnImplicitHeight
            mBtnRadius: 20
            mBtnBkgColor: mCfcBkgColor
            mBtnTxtColor: mCfcTextColor
            mBtnDefaultText: "Pomodoro"
            onMBtnClickedChanged: {
                mBtnClicked ? TimerClass.setCurrentAction("pomodoro") : false;
                setPomodoroAsCurrentColorScheme();
            }
        }

        CustomButton {
            id: shortBreakBtn
            anchors {
                top: clockFace.top
                topMargin: 15
                horizontalCenter: clockFace.horizontalCenter
            }
            mBtnImplicitWidth:  parent.width * (3/10)
            mBtnImplicitHeight: parent.height * (8/100)
            mBtnRadius: 20
            mBtnBkgColor: mCfcBkgColor
            mBtnTxtColor: mCfcTextColor
            mBtnDefaultText: "Short Break"
            onMBtnClickedChanged: {
                mBtnClicked ? TimerClass.setCurrentAction("short-break") : false;
                setShortBreakAsCurrentColorScheme();
            }
        }

        CustomButton {
            id: longBreakBtn
            anchors {
                top: shortBreakBtn.top
                left: shortBreakBtn.right
                leftMargin: 10
            }
            mBtnImplicitWidth:  shortBreakBtn.mBtnImplicitWidth
            mBtnImplicitHeight: shortBreakBtn.mBtnImplicitHeight
            mBtnRadius: 20
            mBtnBkgColor: mCfcBkgColor
            mBtnTxtColor: mCfcTextColor
            mBtnDefaultText: "Long Break"
            onMBtnClickedChanged: {
                mBtnClicked ? TimerClass.setCurrentAction("long-break") : false;
                setLongBreakAsCurrentColorScheme();
            }
        }

        Text {
            id: clockText
            color: mCfcTextColor
            text: TimerClass.remainingTime.toLocaleTimeString(Qt.locale("en_US"), "mm:ss")
            font.bold: true
            font.pointSize: 82
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }

        CustomButton {
            id: playButton
            anchors {
                bottom: clockFace.bottom
                bottomMargin: 20
                horizontalCenter: clockFace.horizontalCenter
            }
            mBtnImplicitWidth: clockFace.width * (4/10)
            mBtnImplicitHeight: clockFace.height * (2/10)
            mBtnBkgColor: mCfcBkgColor
            mBtnTxtColor: mCfcTextColor
            mBtnRadius: 10
            mBtnFontPointSize: 36
            mBtnTextChangeToggle: TimerClass.countDownActive
            mBtnDefaultText: "START"
            mBtnSecondaryText: "STOP"
            onMBtnClickedChanged: {
                mBtnClicked ? TimerClass.countDownActive = !TimerClass.countDownActive : false;
            }
        }
    }
}
