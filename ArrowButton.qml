/****************************************************************************
**
** 呼出式注解说明-箭头按钮
**
** 说明：
** 以下为呼出式注解说明子控件ArrowButton的实现方法。
**
** 作者： 陈宝超
** 修改日期： 2018/1/12
**
****************************************************************************/
import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: container

    signal leftButtonClicked
    signal rightButtonClicked

    Rectangle {
        id: frame
        anchors.fill: parent
        color: "transparent"
        Image {
            width: parent.width; height: parent.height
            anchors.fill: parent
            source: "qrc:/images/triangle.png"
            rotation: 15
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.LeftButton)
                container.leftButtonClicked()
            else if (mouse.button == Qt.RightButton)
                container.rightButtonClicked()
        }
        hoverEnabled: true
    }
}
