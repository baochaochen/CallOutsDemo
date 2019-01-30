/****************************************************************************
**
** 数字呼出式注解说明
**
** 说明：
** 数字呼出式注解说明（NumberCallOut）由一个箭头（id: arrow)和标签（id: label）以及若干线条组成。
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

    // 箭头的参数
    property double arrowWidth; property double arrowHeight
    // 标签的参数
    property double labelWidth; property double labelHeight
    // 字大小
    property int fontSize
    // 字内容
    property string labelTextContent
    // 字体
    property string fontFamily

    // 箭头
    ArrowButton {
        id: arrow
        width: arrowWidth; height: arrowHeight
        anchors.centerIn: parent
        onLeftButtonClicked: { labelAnimation.start() }
        onRightButtonClicked: { labelAnimation.stop() }
    }
    Rectangle {
        id: arrowBg
        anchors.centerIn: arrow
        color: Qt.rgba(0.5,0.5,0.5,0.9)
        width: arrowWidth * 2
        height: arrowHeight * 2
        radius: arrowWidth * 2
        z: -1
    }


    // 箭头动画
    ParallelAnimation {
        id: arrowAnimation
        NumberAnimation {
            target: arrow
            property: "scale"
            from: 0.0
            to: 1.0
            duration: 500
        }
        NumberAnimation {
            target: arrowBg
            property: "scale"
            from: 0.5
            to: 1.0
            duration: 1000
//            loops: Animation.Infinite
        }
    }

    // 导向线
    Item {
        id: directLine
        Rectangle {
            id: directVLine
            width: 0
            height: 1
            anchors.left: arrow.Center
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
    }

    // 标签
    Rectangle {
        id: label
        x: 70
        y: - (80 + label.height)
        width: 0
        height: labelHeight
        color: "#ffffff"

        Text {
            id: labelText
            width: 0
            text: labelTextContent
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontFamily
            font.pointSize: 22
            color: "#000000"
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
                target: arrow
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 400
            }
            NumberAnimation {
                target: arrow
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
            }

            // 2.3 标签动画
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: label
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 300
                    }
                    NumberAnimation {
                        target: label
                        property: "width"
                        from: 0
                        to: labelWidth
                        duration: 300
                    }
                    SmoothedAnimation {
                        target: labelText
                        property: "visible"
                        from: 0
                        to: 1
                        duration: 300
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: label
                        property: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: 200
                    }
                    PropertyAnimation {
                        target: label
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 200
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: label
                        property: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: 200
                    }
                    PropertyAnimation {
                        target: label
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 200
                    }
                }
            }
        }
    }
    Component.onCompleted: { labelAnimation.start() }
}
