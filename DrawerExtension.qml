import QtQuick 2.4
import QtQuick.Controls 2.0


Item {
    anchors.fill: parent

    ListModel{
        id:extensionList
        ListElement{name:"none"}
        ListElement{name:"detect"}
    }
    Item{
        id:selectExtension
        anchors.top: parent.top
        anchors.margins: 7
        anchors.left: parent.left
        ComboBox {
            id: selectExtensionComboBox
            anchors.left: parent.left
            anchors.top: parent.top
            model:extensionList
        }
    }
}


