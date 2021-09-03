import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: customButtonComponent

    width: buttonBkg.implicitWidth
    height: buttonBkg.implicitHeight

    property bool mBtnClicked: mButton.pressed

    property real mBtnImplicitWidth: 0
    property real mBtnImplicitHeight: 0
    property string mBtnBkgColor: "#ff0000"
    property string mBtnTxtColor: "#00FF00"
    property int mBtnRadius: 0
    property int mBtnFontPointSize: 11

    property bool mBtnTextChangeToggle: false
    property string mBtnDefaultText: "FILL-ME"
    property string mBtnSecondaryText: "FILL-ME"

    property string mBtnImageUrl: ""

    Button {
        id: mButton
        anchors.fill: parent
        background: Rectangle {
            id: buttonBkg
            implicitWidth: mBtnImplicitWidth
            implicitHeight: mBtnImplicitHeight
            radius: mBtnRadius
            color: mBtnBkgColor

            Text {
                id: buttonText
                text: mBtnDefaultText
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: mBtnFontPointSize
                color: mBtnTxtColor
                anchors.centerIn: parent

                Image {
                    id: buttonImage
                    fillMode: Image.PreserveAspectFit
                    source: mBtnImageUrl
                    anchors {
                        top: buttonText.top
                        bottom: buttonText.bottom
                        right: buttonText.left
                        rightMargin: 2
                    }
                }

                states: [
                    State {
                        name: "clicked"
                        when: mBtnTextChangeToggle
                        PropertyChanges {
                            target: buttonText;
                            text: mBtnSecondaryText
                        }
                    }
                ]
            }
            states: [
                State {
                    name: "clicked"
                    when: mButton.pressed
                    PropertyChanges {
                        target: buttonBkg;
                        color: Qt.darker(mBtnBkgColor)
                    }
                }
            ]
        }
    }
}
