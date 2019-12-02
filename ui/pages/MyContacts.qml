import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/components"

NavigationPage {
    id: page
    objectName: "pages/MyContacts"

    property var headerComponent: loaderHeaderDefault.item
    onHeaderComponentChanged: headerComponent.title = qsTr("My Contacts")

    content: Column {

    }
}
