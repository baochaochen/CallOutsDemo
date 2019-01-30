/****************************************************************************
**
** 呼出式注解说明-点按钮
**
** 说明：
** 以下为呼出式注解说明子控件DotButton的实现方法。
**
** 作者： 陈宝超
** 修改日期： 2018/1/12
**
****************************************************************************/
import QtQuick 2.9

Item {
    id: container

    signal leftButtonClicked
    signal rightButtonClicked

    Rectangle {
        id: frame
        anchors.fill: parent
        color: Qt.rgba(0.5,0.5,0.5,0.9)
        width: 12
        height: 12
        radius: 12

        Rectangle {
            width: parent.width / 3
            height: parent.height / 3
            color: "#ffffff"
            anchors.centerIn: parent
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button == Qt.LeftButton) {
                container.leftButtonClicked()
            }
            else if (mouse.button == Qt.RightButton) {
                container.rightButtonClicked()
            }
        }
        hoverEnabled: true
    }
}
