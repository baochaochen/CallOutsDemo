/****************************************************************************
**
** 圆环图-样式1
**
** 说明：
** 圆环图-样式1（SpinWidget）由单张由圆的中心旋转复制成的刻度线 以及若干线条组成。
**
** 作者： 陈宝超
** 修改日期： 2018/1/17
**
****************************************************************************/

import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: root

    property double spinWidth
    property double spinHeight
    // 数字
    property int labelNum
    // 灰色圈数值（对应数组成员的index）
    property int darkVal
    // 旋转角度数组 （负值为逆时针旋转）
    property var angleArray: [0,-8,-16,-24,-32,-40,-48,-56,-64,-72,-80,
                                -88,-96,-104,-112,-120,-128,-136,-144,-152,-160,
                                -168,-176,-184,-192,-200,-208,-216,-224,-232,-240,
                                -248,-256,-264,-272,-280,-288,-296,-304,-312]

    Rectangle {
        width: spinWidth
        height: spinHeight
        color: "transparent"

        Repeater {
            model: angleArray.slice(0,darkVal)
            Image {
                id: circleDark
                source: "qrc:/images/SpinWidget/circle_dark.png"
                width: spinWidth; height: spinHeight
                anchors.centerIn: parent
                rotation: modelData
            }
        }

        // 3条背景线
        Rectangle {
            id: backgroundLines
            z: -1
            x: parent.width / 2
            y: parent.height / 2
            Rectangle {
                width: spinWidth / 4
                height: 2
                color: "#565656"
                x: spinWidth / 5
                transform: Rotation { origin.x: -spinWidth / 5 ; origin.y: 0; angle: 145}
                smooth: true
            }
            Rectangle {
                width: spinWidth / 4
                height: 2
                color: "#565656"
                x: spinWidth / 5
                transform: Rotation { origin.x: -spinWidth / 5 ; origin.y: 0; angle: 270}
                smooth: true
            }
            Rectangle {
                width: spinWidth / 4
                height: 2
                color: "#565656"
                x: spinWidth / 5
                transform: Rotation { origin.x: -spinWidth / 5 ; origin.y: 0; angle: 35}
                smooth: true
            }

            // 背景线动画
            PropertyAnimation {
                target: backgroundLines
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 300
                running: true
            }
            SequentialAnimation {
                NumberAnimation {
                    target: backgroundLines
                    property: "rotation"
                    from: 0
                    to: -15
                    duration: 2000
                }
                NumberAnimation {
                    target: backgroundLines
                    property: "rotation"
                    from: -15
                    to: 0
                    duration: 2000
                }
                NumberAnimation {
                    target: backgroundLines
                    property: "rotation"
                    from: 0
                    to: 15
                    duration: 2000
                }
                NumberAnimation {
                    target: backgroundLines
                    property: "rotation"
                    from: 15
                    to: 0
                    duration: 2000
                }
                loops: Animation.Infinite
                running: true
            }
        }

        // 数字
        Label {
            font.family: "Microsoft Sans Serif";
            font.pixelSize: spinHeight / 4;
            anchors.centerIn: parent;
            text: labelNum
            color: "#ffffff"
        }

        Image {
            id: scalesImg
            anchors.fill: parent
            source: "qrc:/images/SpinWidget/scales.png"
        }
        Image {
            id: scalesBigImg
            anchors.fill: parent
            source: "qrc:/images/SpinWidget/scales_big.png"
        }
        Image {
            id: scalesOutside
            anchors.centerIn: parent
            width: spinWidth * 2.2; height: spinHeight * 2.2
            source: "qrc:/images/SpinWidget3/scale_middle_outside.png"
        }

        // 亮黄圈（单张图片旋转复制而成）
        Repeater {
            model: angleArray.slice(0,labelNum * 0.40)  // 切分数组
            Image {
                id: circleLight
                source: "qrc:/images/SpinWidget/circle_light.png"
                width: spinWidth; height: spinWidth
                anchors.centerIn: parent
                rotation: modelData
            }
        }
    }

    // 动画
    ParallelAnimation {
        running: true

        PropertyAnimation {
            target: root
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 1000
        }
        NumberAnimation {
            target: root
            property: "darkVal"
            from: 0
            to: 40
            duration: 1000
        }
    }
}
