/****************************************************************************
**
** 呼出式注解说明
**
** 说明：
** 呼出式注解说明（CallOut）由一个点（id: dot)和标签（id: label）以及若干线条组成。
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

//    signal callOutleftButtonClicked
//    signal callOutrightButtonClicked

    // 点的参数
    property double dotWidth; property double dotHeight
    // 标签的参数
    property double labelWidth; property double labelHeight
    // 字大小
    property int fontSize
    // 字内容
    property string labelTextContent
    // 字体
    property string fontFamily

    // 点
    DotButton {
        id: dot
        width: dotWidth; height: dotHeight
        anchors.centerIn: parent
        onLeftButtonClicked: { labelAnimation.start() }
        onRightButtonClicked: { labelAnimation.stop() }
    }

    // 点动画
    ParallelAnimation {
        id: dotAnimation
        NumberAnimation {
            target: dot
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 1000
        }
        NumberAnimation {
            target: dot
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 1000
        }
    }

    // 导向线
    Item {
        id: directLine
        Rectangle {
            id: directVLine
            width: 0
            height: 1
            anchors.left: dot.Center
            color: "#ffffff"
            transformOrigin: Item.TopLeft
            rotation: 315

        }
        Rectangle {
            id: directHLine
            width: 0
            height: 1
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
            height: 1
            x: 69
            y: -111
            color: "#ffffff"
            transformOrigin: Item.TopLeft
            rotation: 90

        }
        Rectangle {
            id: transitionHLine
            width: 0
            height: 1
            x: 70
            y: -80
            color: "#ffffff"
        }
    }

    // 标签
    Rectangle {
        id: label
        x: 70
        y: - (80 + label.height)
        width: 0
        height: labelHeight
        color: "#34345d"
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
//                target: transitionHLine
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

        // 1. 点动画
        ParallelAnimation {
            PropertyAnimation {
                target: dot
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 400
            }
            NumberAnimation {
                target: dot
                property: "scale"
                from: 0.0
                to: 1.0
                duration: 400
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
                        target: transitionVLine
                        property: "y"
                        from: - (labelHeight + 81)
                        to: -81
                        duration: 300
                    }
                    NumberAnimation {
                        target: transitionVLine
                        property: "width"
                        from: labelHeight
                        to: 0
                        duration: 300
                    }
                }

                ParallelAnimation {
                    NumberAnimation {
                        target: transitionHLine
                        property: "x"
                        from: 70
                        to: labelWidth + 70.0
                        duration: 600
                    }
                    NumberAnimation {
                        target: transitionHLine
                        property: "width"
                        from: labelWidth
                        to: 0
                        duration: 600
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
