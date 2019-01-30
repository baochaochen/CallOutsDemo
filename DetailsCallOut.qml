/****************************************************************************
**
** 详情呼出式注解说明
**
** 说明：
** 详情呼出式注解说明（DetailsCallOut）由一个方框（id: square)和标签（id: label）以及若干线条组成。
**
** 作者： 陈宝超
** 修改日期： 2018/1/12
**
****************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0

Item {
    id: root

    // 方框的参数
    property double squareWidth; property double squareHeight
    // 标签的参数
    property double labelWidth; property double labelHeight
    // 字大小
    property int fontSize
    // 字内容
    property string labelTextContent
    // 字体
    property string fontFamily

    // 方框
    SquareButton {
        id: square
        width: squareWidth; height: squareHeight
        anchors.centerIn: parent
        onLeftButtonClicked: { labelAnimation.start() }
        onRightButtonClicked: { labelAnimation.stop() }
    }

    Rectangle {
        id: squareBg
        anchors.centerIn: square
        color: Qt.rgba(0.5,0.5,0.5,0.9)
        width: squareWidth * 2
        height: squareHeight * 2
        radius: squareWidth * 2
        z: -1

        Image {
            id: squareBorder
            width: parent.width * 4; height: parent.height * 4
            anchors.centerIn: parent
            source: "qrc:/images/rectangle.png"
        }
    }

    // 导向线
    Item {
        id: directLine
        Rectangle {
            id: directVLine
            width: 0
            height: 2
            anchors.left: square.Center
            color: "#ffffff"
            transformOrigin: Item.TopLeft
            rotation: 315

        }
        Rectangle {
            id: directHLine
            width: 0
            height: 2
            x: 70
            y: -71
            color: "#ffffff"
        }
    }

    // 过渡线
    Item {
        id: transitionLine
        Rectangle {
            id: transitionVLine
            width: 0
            height: 2
            x: 72
            y: -109
            color: Qt.rgba(0.5,0.5,0.5,0.9)
            transformOrigin: Item.TopLeft
            rotation: 90

        }
        Rectangle {
            id: transitionHBottomLine
            width: 0
            height: 2
            x: 70
            y: -80
            color: Qt.rgba(0.5,0.5,0.5,0.9)
        }
        Rectangle {
            id: transitionHTopLine
            width: 0
            height: 2
            x: 70
            y: -(80 + labelHeight + 2)
            color: Qt.rgba(0.5,0.5,0.5,0.9)
        }
    }

    // 标签
    Rectangle {
        id: label
        x: 70
        y: - (80 + label.height)
        width: 0
        height: labelHeight
        color: "transparent"
        Text {
            id: labelText
            width: 0
            text: labelTextContent
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontFamily
            font.pointSize: fontSize
            color: "#ffffff"
            visible: false
        }
    }

    // 呼出注解动画
    SequentialAnimation {
        id: labelAnimation

//        // 0. 复位
//        ParallelAnimation {
//            id: disappearAnimation
//            NumberAnimation {
//                target: directVLine
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: directHLine
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: transitionVLine
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: transitionHBottomLine
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: transitionHTopLine
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: label
//                property: "width"
//                from: 0
//                to: 0
//                duration: 100
//            }
//            NumberAnimation {
//                target: labelText
//                property: "visible"
//                from: 0
//                to: 0
//                duration: 100
//            }
//        }

        // 1. 方框动画
        ParallelAnimation {
            NumberAnimation {
                target: squareBorder
                property: "scale"
                from: 1.0
                to: 0.0
                duration: 800
            }
            NumberAnimation {
                target: squareBorder
                property: "rotation"
                from: 0
                to: 360
                duration: 800
            }
            PropertyAnimation {
                target: squareBorder
                property: "opacity"
                from: 1.0
                to: 0
                duration: 1000
            }
            NumberAnimation {
                target: square
                property: "scale"
                from: 0.0
                to: 1.0
                duration: 800
            }
            NumberAnimation {
                target: squareBg
                property: "scale"
                from: 0.0
                to: 1.0
                duration: 800
            }
        }
        ParallelAnimation {
            // 2.1 导向线动画
            SequentialAnimation {
                NumberAnimation {
                    target: directVLine
                    property: "width"
                    from: 0
                    to: 100
                    duration: 300
                }
                NumberAnimation {
                    target: directHLine
                    property: "width"
                    from: 0
                    to: labelWidth
                    duration: 300
                }
            }

            // 2.2 过渡线动画
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: transitionHBottomLine
                        property: "x"
                        from: labelWidth + 70.0
                        to: 70
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionHBottomLine
                        property: "width"
                        from: 0
                        to: labelWidth / 2
                        duration: 300
                    }
                }

                ParallelAnimation {
                    NumberAnimation {
                        target: transitionVLine
                        property: "y"
                        from: -80
                        to: - (labelHeight + 80)
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionVLine
                        property: "width"
                        from: 0
                        to: labelHeight
                        duration: 300
                    }
                }

                ParallelAnimation {
                    NumberAnimation {
                        target: transitionHTopLine
                        property: "x"
                        from: 70
                        to: 70 + labelWidth
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionHTopLine
                        property: "width"
                        from: 0
                        to: labelWidth
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionHTopLine
                        property: "width"
                        from: labelWidth
                        to: 0
                        duration: 300
                    }
                }

                ParallelAnimation {
                    NumberAnimation {
                        target: transitionHTopLine
                        property: "x"
                        from: 70
                        to: 70
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionHTopLine
                        property: "width"
                        from: 0
                        to: labelWidth / 4
                        duration: 300
                    }
                }
            }

            // 2.3 标签动画
            ParallelAnimation {
                PropertyAnimation {
                    target: label
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 800
                }
                NumberAnimation {
                    target: label
                    property: "width"
                    from: 0
                    to: labelWidth
                    duration: 800
                }
                SmoothedAnimation {
                    target: labelText
                    property: "visible"
                    from: 0
                    to: 1
                    duration: 800
                }
            }
        }
    }
    Component.onCompleted: { labelAnimation.start() }
}

