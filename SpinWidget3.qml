/****************************************************************************
**
** 圆环图-样式3
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
    // 旋转角度数组（对应数组成员的index）
    property var angleArray: [0,-16,-32,-48,-64,-80,
        -96,-112,-128,-144,-160,
        -176,-192,-208,-224,-240,
        -256,-272]

    Rectangle {
        width: spinWidth
        height: spinHeight
        color: "transparent"

        // 灰色圈（单张图片旋转复制而成）
        Repeater {
            model: angleArray
            Image {
                id: circleDark
                source: "qrc:/images/SpinWidget3/circle_dark.png"
                anchors.centerIn: parent
                width: spinWidth * 2 ; height: spinHeight * 2
                rotation: modelData
            }
        }

        Label {
            font.family: "Microsoft Sans Serif";
            font.pixelSize: spinHeight / 3;
            anchors.centerIn: parent;
            text:  labelNum
            color: "#ffffff"
        }

        // 内层-圆环
        Image {
            id: scalesImg
            width: spinWidth * 2.2
            height: spinHeight * 2.2
            anchors.centerIn: parent
            source: "qrc:/images/SpinWidget3/scale_small.png"
            opacity: 0.0
        }
        // 中间层-刻度线圈
        Image {
            id: scalesMiddleInsideImg
            width: spinWidth * 2.2
            height: spinHeight * 2.2
            anchors.centerIn: parent
            source: "qrc:/images/SpinWidget3/scale_middle_inside.png"
            opacity: 0.0
        }
        // 中间层-外侧圆环
        Image {
            id: scalesMiddleOutsideImg
            width: spinWidth * 2.2
            height: spinHeight * 2.2
            anchors.centerIn: parent
            source: "qrc:/images/SpinWidget3/scale_middle_outside.png"
            opacity: 0.0
        }
        // 外部三层不封口圈
        Image {
            id: scalesLargeImg
            width: spinWidth * 2.2
            height: spinHeight * 2.2
            anchors.centerIn: parent
            source: "qrc:/images/SpinWidget3/scale_large.png"
            opacity: 0.0
        }

        // 亮黄圈（单张图片旋转复制而成）
        Repeater {
            model: angleArray.slice(0, labelNum * 0.18)  // 切分数组
            Image {
                id: circleLight
                source: "qrc:/images/SpinWidget3/circle_light.png"
                anchors.centerIn: parent
                width: spinWidth * 2; height: spinHeight * 2
                rotation: modelData
            }
        }
    }

    // 动画
    SequentialAnimation {
        PropertyAnimation {
            target: scalesMiddleInsideImg
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 400
        }
        ParallelAnimation {
            PropertyAnimation {
                target: scalesImg
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 800
            }
            PropertyAnimation {
                target: scalesMiddleOutsideImg
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 800
            }
            PropertyAnimation {
                target: scalesLargeImg
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 800
            }
        }
        running: true
    }
}
