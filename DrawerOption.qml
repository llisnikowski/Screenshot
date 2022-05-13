import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.3

Item{
    anchors.fill: parent
    //padding: 4;

    FileDialog{
        id: openFolderSave
        title: "Please choose a folder"
        selectFolder: true
        onAccepted: {
            var path = openFolderSave.folder.toString();
            path = path.replace(/^(file:\/{3})/,"");
            //cleanPath = decodeURIComponent(path);
            console.log("You chose: " + path );
            pathText.text = path
            screenshot.pathText = path;
        }
        onRejected: {
            //console.log("Canceled")
        }
    }

    Item{
        id:hideThisWindowRow
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        height: 30
        //anchors.margins: 7
        CheckBox{
            id: hideThisWindowCheckBox
            anchors.verticalCenter: parent.verticalCenter
            checked: screenshot.hideThisWindow
            text: qsTr("Hide this window")

            onToggled: {
                screenshot.hideThisWindow = hideThisWindowCheckBox.checked
            }
        }
    }

    Item{
        id: copyImageRow
        anchors.top: hideThisWindowRow.bottom
        anchors.left: parent.left
        height: 30
        //anchors.margins: 7
        //padding: 10
        CheckBox{
            id: copyImageCheckBox
            checked: screenshot.copyImageOpt
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Copy to clipboard")

            onToggled: {
                screenshot.copyImageOpt = copyImageCheckBox.checked
            }
        }
        Button{
            id: copyImageButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: copyImageCheckBox.right
            //implicitWidth: 30;
            text: "copy"
            height: copyImageCheckBox.height * 0.6
            //width: 30
            onClicked: {
                screenshot.copyImageToClipboard();
            }
        }
    }

    Item{
        id:saveImageRow
        anchors.top: copyImageRow.bottom
        anchors.left: parent.left
        height: 30
        CheckBox{
            id: saveImageCheckBox
            anchors.verticalCenter: parent.verticalCenter
            checked: screenshot.saveImageOpt
            text: qsTr("Save image")

            onToggled: {
                screenshot.saveImageOpt = saveImageCheckBox.checked
            }
        }
    }

    Item{
        id: pathTextRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: saveImageRow.bottom
        anchors.margins: 7
        //padding: 10
        //spacing: 5
        height: 30

        //Rectangle { color: "red"; anchors.fill: parent }
        Text{
            id: pathTextDescription
            text: "Path:"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        TextField{
            id: pathText
            font.pixelSize: Qt.application.font.pixelSize
            anchors.left: pathTextDescription.right
            anchors.right: pathButton.left
            anchors.margins: 5
            anchors.verticalCenter: parent.verticalCenter
            onEditingFinished:{
                screenshot.pathText = openFolderSave.folder.toString();;
            }
        }

        Button{
            id: pathButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            implicitWidth: 30;
            text: ".."
            height: pathText.height
            width: 30
            onClicked: {
                openFolderSave.open()
            }
        }
    }

    Item{
        id: nameTextRow
        anchors.top: pathTextRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 7
        //padding: 10
        //spacing: 5
        height: 30

        Text{
            id: nameTextDescription
            text: "Name image:"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }
        TextField{
            id: nameText
            font.pixelSize: Qt.application.font.pixelSize
            anchors.left: nameTextDescription.right
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            onEditingFinished:{
                screenshot.imageNameText = nameText.text
            }
        }
    }

    Item{
        anchors.top: nameTextRow.bottom
        anchors.left: parent.left
        anchors.margins: 7
        //spacing: 5
        height: 10

        Text{
            text: " @ - curent number image"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Qt.application.font.pixelSize
        }
    }


    Item{
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height: 40
    Row{
        id: authorText1
        anchors.left: parent.left
        anchors.margins: 7
        spacing: 5

        Text{
            text: "Author:"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Qt.application.font.pixelSize
        }
    }
    Row{
        anchors.top: authorText1.bottom
        anchors.left: parent.left
        anchors.margins: 7
        spacing: 5

        Text{
            text: "Łukasz Liśnikowski"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Qt.application.font.pixelSize
        }
        Text{
            text: "l.lisnikowski@gmail.com"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Qt.application.font.pixelSize
        }
    }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
