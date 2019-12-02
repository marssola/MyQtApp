import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.1

import UiKit 1.0
import "qrc:/components"

ApplicationWindow {
    id: window
    visible: true
    width: 414
    height: 736
    title: qsTr("Hello MyQtApp")

    Settings {
        id: conf
        property bool dark: false
        onDarkChanged: window.UiKit.dark = dark

        property bool logged: false
        property string userToken
    }

    ListModel {
        id: pagesModel
        property string page: ""

        ListElement {
            name: qsTr("Search")
            page: "pages/Search"
            iconName: "search"
        }

        ListElement {
            name: qsTr("Contacts")
            page: "pages/MyContacts"
            iconName: "people"
        }

        ListElement {
            name: qsTr("Messages")
            page: "pages/Messages"
            iconName: "message"
        }

        ListElement {
            name: qsTr("My Account")
            page: "pages/MyAccount"
            iconName: "person"
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent
        prefix_file: "qrc:/ui/"
        suffix_file: ".qml"

        initialItem: prefix_file + (conf.logged ? pagesModel.get(0).page : "pages/Login") + suffix_file
        onCurrentItemChanged: {
            if (currentItem.headerComponent)
                window.header = currentItem.headerComponent
            if (currentItem.footerComponent)
                window.footer = currentItem.footerComponent
        }
    }

    Loader {
        id: loaderHeaderDefault
        source: "qrc:/ui/navigation/HeaderBar.qml"
        visible: false

        onLoaded: {
            item.shaderSourceItem = stackView
//            window.header = item
        }
    }

    Component {
        id: componentFooterBar

        FooterBar {
            id: footer
            visible: false

            model: pagesModel
            parent: stackView
            shaderSourceItem: stackView

            delegate: TabButton {
                text: name
                icon.name: iconName
                font.pixelSize: 14
                display: footer.iconPosition
                onClicked: stackView.setPage(page)
            }
        }
    }

    Loader {
        id: loaderFooterDefault
        visible: false

        sourceComponent: componentFooterBar
//        onLoaded: window.footer = item
    }

    Loader {
        id: loaderDialog

        source: "qrc:/ui/dialogs/StyleDialog.qml"
        onLoaded: {
            item.shaderSourceItem = stackView
        }
    }

    Component.onCompleted: {
        window.UiKit.dark = conf.dark
    }
}
