/****************************************************************************
**
** 圆环图-样式2
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
    // 旋转角度数组
    property var angleArray: [-16,-20,-24,-28,-32,-36,
        -40,-44,-48,-52,-56,
        -60,-64,-68,-72,-76,
        -80,-84,-88,-92,-96,
        -100,-104,-108,-112,-116,
        -120,-124,-128,-132,-136,
        -140,-144,-148,-152,-156,
        -160,-164,-168,-172,-176,
        -180,-184,-188,-192,-196,
        -200,-204,-208,-212,-216,
        -220,-224,-228,-232,-236,
        -240,-244,-248,-252,-256,
        -260,-264,-268,-272,-276,
        -280,-284,-288,-292,-296,
        -300,-304,-308,-312,-316,
        -320,-324,-328,-332,-336,
        -340,-344,-348,-352,-356,
        -360,-364,-368,-372]

    Rectangle {
        width: spinWidth
        height: spinHeight
        color: "transparent"

        // 灰色圈（单张图片旋转复制而成）
        Repeater {
            model: angleArray
            Image {
                id: circleDark
                source: "qrc:/images/SpinWidget2/circle_dark.png"
                anchors.centerIn: parent
                width: spinWidth * 2; height: spinWidth * 2
                rotation: modelData
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
            width: spinWidth * 1.2
            height: spinHeight * 1.2
            anchors.centerIn: parent
            source: "qrc:/images/SpinWidget2/scale.png"
            opacity: 0.0
        }

        // 亮黄圈（单张图片旋转复制而成）
        Repeater {
            model: angleArray.slice(0,labelNum * 0.90)    // 切分数组
            Image {
                id: circleLight
                source: "qrc:/images/SpinWidget2/circle_light.png"
                anchors.centerIn: parent
                width: spinWidth * 2; height: spinWidth * 2
                rotation: modelData
            }
        }
    }

    // 动画
    SequentialAnimation {
        PropertyAnimation {
            target: scalesImg
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 800
        }
        PropertyAnimation {
            target: root
            property: "opacity"
            from: 0.5
            to: 1.0
            duration: 300
            loops: 3
        }
        running: true
    }
}
