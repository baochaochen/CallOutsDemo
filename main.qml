/****************************************************************************
**
** 呼出式注解说明-演示
**
** 说明：
** 以下展示三种CallOut样板。
**
** 作者： 陈宝超
** 修改日期： 2018/1/12
**
****************************************************************************/

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: 960
    minimumHeight: 680
    maximumWidth: 960
    maximumHeight: 680
    title: qsTr("CallOuts Demo")
    color: "#000000"

    property int loadIndex: 0

    // 加载字体文件
    FontLoader {id: localFont; source: "qrc:/NotoSansHans-Regular.otf"}

    Rectangle {
        id: moveArea
        width: parent.width
        height: 540
        anchors.top: parent.top
        color: "transparent"

        Image {
            id: backgroundImg
            anchors.fill: parent
            source: "qrc:/images/bg.jpg"
            opacity: 0.3
        }

        Loader {
            id: loader
            x: mainWindow.width / 2
            y: mainWindow.height / 2
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if (mouse.button == Qt.LeftButton && loadIndex == 1) {
                    loader.sourceComponent = callOutComponent
                }
                else if (mouse.button == Qt.LeftButton && loadIndex == 2) {
                    loader.sourceComponent = numberCallOutComponent
                }
                else if (mouse.button == Qt.LeftButton && loadIndex == 3) {
                    loader.sourceComponent = detailsCallOutComponent
                }
                else if (mouse.button == Qt.RightButton) {
                    loader.sourceComponent = undefined
                }
                loader.x = Qt.binding(function() {
                    if (mouseX < moveArea.width)
                        return mouseX
                    else if (mouseX >= moveArea.width)
                        return moveArea.width
                    else
                        return 0
                })
                loader.y = Qt.binding(function() {
                    if (mouseY < moveArea.height)
                        return mouseY
                    else if (mouseY >= moveArea.height)
                        return moveArea.height
                    else
                        return 0
                })
            }
        }
    }

    Component {
        id: callOutComponent
        CallOut {
            id: callOut

            dotWidth: 18; dotHeight: 18
            labelWidth: 210; labelHeight: 32
            labelTextContent: "MICHAEL BLACK"
            fontSize: 22; fontFamily: localFont.name
        }
    }
    Component {
        id: numberCallOutComponent
        NumberCallOut {
            id: numberCallOut
            arrowWidth: 12; arrowHeight: 12
            labelWidth: 48; labelHeight: 32
            labelTextContent: "23"
            fontSize: 22; fontFamily: localFont.name
        }
    }
    Component {
        id: detailsCallOutComponent
        DetailsCallOut {
            id: detailsCallOut
            squareWidth: 12; squareHeight: 12
            labelWidth: 180; labelHeight: 32
            labelTextContent: "DETAIL INFO"
            fontSize: 22; fontFamily: localFont.name
        }
    }

   RowLayout {
        spacing: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        Rectangle {
            id: button1
            width: 120
            height: 100
            border.width: 5
            border.color: "#5e5e5e"
            smooth: true

            Image {
                anchors.fill: parent
                anchors.margins: 5
                source:  "qrc:/images/1.jpg"
            }
            MouseArea {
                id: mouse1
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button == Qt.LeftButton)
                    {
//                        loader.sourceComponent = callOutComponent
                        loadIndex = 1
                        button1.border.color = "#0e7b96"
                        button2.border.color = "#5e5e5e"
                        button3.border.color = "#5e5e5e"
                    }
                    else if (mouse.button == Qt.RightButton)
                    {

                    }
                }
            }
        }
        Rectangle {
            id: button2
            width: 120
            height: 100
            border.width: 5
            border.color: "#5e5e5e"
            smooth: true

            Image {
                anchors.fill: parent
                anchors.margins: 5
                source:  "qrc:/images/2.jpg"
            }
            MouseArea {
                id: mouse2
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked:
                    if (mouse.button == Qt.LeftButton)
                    {
                        loadIndex = 2
                        button1.border.color = "#5e5e5e"
                        button2.border.color = "#0e7b96"
                        button3.border.color = "#5e5e5e"
                    }
                    else if (mouse.button == Qt.RightButton) {

                    }
            }
        }
        Rectangle {
            id: button3
            width: 120
            height: 100
            border.width: 5
            border.color: "#5e5e5e"
            smooth: true

            Image {
                anchors.fill: parent
                anchors.margins: 5
                source:  "qrc:/images/3.jpg"
            }
            MouseArea {
                id: mouse3
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked:
                    if (mouse.button == Qt.LeftButton)
                    {
                        loadIndex = 3
                        button1.border.color = "#5e5e5e"
                        button2.border.color = "#5e5e5e"
                        button3.border.color = "#0e7b96"
                    }
                    else if (mouse.button == Qt.RightButton) {

                    }
            }
        }
    }

}
