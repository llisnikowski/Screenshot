import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.15


ApplicationWindow {
    id: window
    width: 480
    height: 360

    visible: true
    title: qsTr("Screenshot_7L 1.0")

    //property QList sceensList: screenshot.screenQList

    Component.onCompleted: {
        screenshot.newScreenshot()
    }


    header: ToolBar{
        id: head
        Row {
            Keys.onPressed: {
                    if (event.key === Qt.Key_Left) {
                        console.log("move left");
                        event.accepted = true;
                    }
                }
            ToolButton{
                id: sceenshotButton
                text: "\u26F6"
                font.pixelSize: Qt.application.font.pixelSize * 1.7
                font.bold: true
                onClicked: {
                    option.close()
                    if(screenshot.hideThisWindow){
                    //if(false){
                        //window.visible = false;
                        window.hide()
                        showWindowTimer.start()
                    }
                    else{
                        screenshot.newScreenshot()
                    }
                }

            }


            ToolButton{
                id: boxButton
                text: "\u2B1A"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                font.bold: true
                onClicked: {
                    var component = Qt.createComponent("SelectRect.qml");
                    var browserWindow = component.createObject(this);
                    browserWindow.show();
                }

            }
            /*ToolButton{
                id: extensionButton
                text: "\u2664"
                font.pixelSize: Qt.application.font.pixelSize * 1.7
                font.bold: true
                onClicked: {
                    if(extensionDrawer.visible){
                        extensionDrawer.close()
                    }else{
                        extensionDrawer.open()
                    }
                }

            }*/
            ToolButton{
                id: optionsButton
                text: option.visible? "\u25C0" : "\u2630";
                font.pixelSize: Qt.application.font.pixelSize * 1.6

                onClicked: {
                    if(option.visible){
                        option.close()
                    }else{
                        option.open()
                    }
                }
            }



        }
        /*Label {
            text: window.title
            anchors.centerIn: parent
        }*/
    }




    Rectangle {
        anchors.fill: parent
        anchors.margins: 7;
        Image{
            anchors.fill: parent
            anchors.centerIn: parent.Centers
            source: screenshot.ssImage
            sourceSize.width: window.width - parent.spacing*2
        }
    }

    Timer{
        id: showWindowTimer
        interval: 200
        repeat: false
        onTriggered:{
            screenshot.newScreenshot()
            window.show()
        }
    }





//--| OptionMain |--
    Drawer {
        id: option
        height: window.height-header.height
        width: window.width * 0.66
        y: header.height
        padding: 2

        DrawerOption{}
    }


    //--| ExtensionMain |--
    Drawer {
        id: extensionDrawer
        height: window.height-header.height
        width: window.width * 0.66
        y: header.height
        padding: 2
        DrawerExtension{}
    }


}













