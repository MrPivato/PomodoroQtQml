import QtQuick 2.0

Item {
    id: navBarComponent

    property string pageToLoad: "page"

    CustomButton {
        id: settingsBtn
        anchors {
            top: parent.top
            topMargin: parent.height * (2/10)
            left: parent.horizontalCenter
            leftMargin: 7
        }
        mBtnImplicitWidth:  parent.width * (15/100)
        mBtnImplicitHeight: parent.height * (9/10)
        mBtnRadius: 20
        mBtnBkgColor: currentClockFaceColor
        mBtnTxtColor: currentTextColor
        mBtnDefaultText: "Settings"
        mBtnImageUrl: ""
        onMBtnClickedChanged: {
            mBtnClicked ? pageToLoad = "SettingsView" : false;
        }
    }

    CustomButton {
        id: clockBtn
        anchors {
            top: settingsBtn.anchors.top
            topMargin: settingsBtn.anchors.topMargin
            right: settingsBtn.anchors.left
            rightMargin: settingsBtn.anchors.leftMargin
        }
        mBtnImplicitWidth:  settingsBtn.mBtnImplicitWidth
        mBtnImplicitHeight: settingsBtn.mBtnImplicitHeight
        mBtnRadius: 20
        mBtnBkgColor: currentClockFaceColor
        mBtnTxtColor: currentTextColor
        mBtnDefaultText: "Timer"
        mBtnImageUrl: ""
        onMBtnClickedChanged: {
            mBtnClicked ? pageToLoad = "ClockFaceView" : false;
        }
    }
}
