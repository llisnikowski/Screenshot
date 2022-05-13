import QtQuick 2.0
import QtQuick.Window 2.0

Window {
    id: selectRect
    title: qsTr("SelectRect")
    width: screenshot.geometryScreens.width
    height: screenshot.geometryScreens.height
    x: screenshot.geometryScreens.x
    y: screenshot.geometryScreens.y
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WA_TranslucentBackground
    color: "#00000000"
    //opacity: 0.5


    Component.onCompleted: {
    }

property int rulersSize: 18
property rect ssArea: screenshot.ssArea;


    Rectangle{
        color: "#11F0F0F0"
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
           if (event.key === Qt.Key_Escape || event.key === Qt.Key_Any || event.key === Qt.Key_Enter ||
               event.key === Qt.Key_Alt || event.key === Qt.Key_Control || event.key === Qt.Key_Shift) {
               screenshot.ssArea = Qt.rect(selComp.x,selComp.y,selComp.width,selComp.height)
               selectRect.close();
            }
        }

        Rectangle{
            id: selComp
            border{
                width: 2
                color: "steelblue"
            }
            x:ssArea.x
            y:ssArea.y
            width: ssArea.width
            height: ssArea.height
            color: "#354682B4"

            MouseArea {     // drag mouse area
                anchors.fill: parent
                drag{
                    target: parent
                    minimumX: 0
                    minimumY: 0
                    maximumX: parent.parent.width - parent.width
                    maximumY: parent.parent.height - parent.height
                    smoothed: true
                }
            }

            Rectangle {
                width: rulersSize
                height: rulersSize
                radius: rulersSize
                color: "steelblue"
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    drag{ target: parent; axis: Drag.XAxis }
                    onMouseXChanged: {
                        if(drag.active){
                            selComp.width = selComp.width - mouseX
                            selComp.x = selComp.x + mouseX
                            if(selComp.width < 30)
                                selComp.width = 30
                        }
                    }
                }
            }
            Rectangle {
                width: rulersSize
                height: rulersSize
                radius: rulersSize
                color: "steelblue"
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    drag{ target: parent; axis: Drag.XAxis }
                    onMouseXChanged: {
                        if(drag.active){
                            selComp.width = selComp.width + mouseX
                            if(selComp.width < 50)
                                selComp.width = 50
                        }
                    }
                }
            }
            Rectangle {
                width: rulersSize
                height: rulersSize
                radius: rulersSize
                x: parent.x / 2
                y: 0
                color: "steelblue"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top

                MouseArea {
                    anchors.fill: parent
                    drag{ target: parent; axis: Drag.YAxis }
                    onMouseYChanged: {
                        if(drag.active){
                            selComp.height = selComp.height - mouseY
                            selComp.y = selComp.y + mouseY
                        if(selComp.height < 50)
                            selComp.height = 50
                        }
                    }
                }
            }
            Rectangle {
                width: rulersSize
                height: rulersSize
                radius: rulersSize
                x: parent.x / 2
                y: parent.y
                color: "steelblue"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom

                MouseArea {
                    anchors.fill: parent
                    drag{ target: parent; axis: Drag.YAxis }
                    onMouseYChanged: {
                        if(drag.active){
                            selComp.height = selComp.height + mouseY
                            if(selComp.height < 50)
                                selComp.height = 50
                        }
                    }
                }
            }
        }
    }


}
