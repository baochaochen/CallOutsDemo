import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: 860
    minimumHeight: 650
    maximumWidth: 860
    maximumHeight: 860
    color: "#000000"

    Image {
        anchors.fill: parent
        source: "qrc:/images/bg.jpg"
        opacity: 0.1
    }

    RowLayout {
        anchors.fill: parent
        spacing: 50

        SpinWidget {
            id: spinWidget
            spinWidth: 300; spinHeight: 300
            x: parent.width / 2 - spinWidth /2
            y: parent.height / 2 - spinHeight /2 + 100
            labelNum: 0
            darkVal: 0
        }

        SpinWidget2 {
            id: spinWidget2
            spinWidth: 250; spinHeight: 250
            x: parent.width / 2 - 400
            y: parent.height / 2 - 300
            labelNum: 0
        }

        SpinWidget3 {
            id: spinWidget3
            spinWidth: 200; spinHeight: 200
            x: parent.width / 2 + 200
            y: parent.height / 2 - 280
            labelNum: 0
        }
    }

    // 滑块
    Slider {
        id: slider
        anchors.bottom: parent.bottom
        width: parent.width
        from: 0
        value: 0
        to: 100
        background: Rectangle {
                 x: slider.leftPadding
                 y: slider.topPadding + slider.availableHeight / 2 - height / 2
                 implicitWidth: 200
                 implicitHeight: 4
                 width: slider.availableWidth
                 height: implicitHeight
                 radius: 2
                 color: "#888888"

                 Rectangle {
                     width: slider.visualPosition * parent.width
                     height: parent.height
                     color: "#c66d1a"
                     radius: 2
                 }
             }

             handle: Rectangle {
                 x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                 y: slider.topPadding + slider.availableHeight / 2 - height / 2
                 implicitWidth: 16
                 implicitHeight: 16
                 radius: 8
                 color: "#f6f6f6"
                 border.color: slider.pressed ? "#c66d1a" : "#888888"
             }
        onValueChanged: {
            spinWidget.labelNum = slider.value
            spinWidget2.labelNum = slider.value
            spinWidget3.labelNum = slider.value
        }
    }
}
