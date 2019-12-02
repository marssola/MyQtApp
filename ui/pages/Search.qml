import QtQuick 2.12
import QtQuick.Controls 2.12

import UiKit 1.0
import "qrc:/components"
import "qrc:/js"

NavigationPage {
    id: page
    objectName: "pages/Search"

    property var headerComponent: loaderHeaderDefault.item
    onHeaderComponentChanged: headerComponent.title = qsTr("Search for developers")

    content: Column {
        padding: 0
        topPadding: UiKit.implicitHeight
        bottomPadding: UiKit.implicitHeight
        spacing: 20

        GroupItems {
            width: parent.width

            ItemControl {
                id: name

                width: parent.width - (parent.padding * 2)
                label: qsTr("Name")
                control: ItemControl.Item.TextField
            }

            ItemControl {
                id: phone

                width: parent.width - (parent.padding * 2)
                label: qsTr("Phone")
                inputMask: "00 00000-0000"
                control: ItemControl.Item.TextField
            }

            ItemControl {
                id: email

                width: parent.width - (parent.padding * 2)
                label: qsTr("E-mail")
                control: ItemControl.Item.TextField
            }

            ItemControl {
                id: password

                width: parent.width - (parent.padding * 2)
                label: qsTr("Password")
                control: ItemControl.Item.TextField
                echoMode: TextField.Password
            }
        }


        Button {
            enabled: !request.busy
            width: parent.width - (parent.padding * 2)
            height: 32
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            highlighted: true
            text: qsTr("Register")
            onClicked: {
                request.path = "/V1/user"
                request.body = {
                    name: name.value,
                    phone: phone.value,
                    email: email.value,
                    password: password.value
                }
                request.method = XMLHttpRequestModel.Method.POST
                request.callback = callback
                request.send()
            }
        }

        BusyIndicator {
            width: parent.width
            running: request.busy
        }

        /*
        Button {
            text: qsTr("Register")
            onClicked: {
                request.path = "/V1/user"
                request.body = {
                    name: "Fenelon Ursulino da Silva",
                    phone: "(11) 96130-8780",
                    email: "fenelon.ursulino@gmail.com",
                    password: "123456"
                }
                request.method = XMLHttpRequestModel.Method.POST
                request.callback = callback
                request.send()
            }
        }

        Button {
            text: qsTr("Authenticate")
            onClicked: {
                request.path = "/V1/user/login"
                request.body = {
                    email: "fenelon.ursulino@hotmail.com",
                    password: "123456"
                }
                request.method = XMLHttpRequestModel.Method.POST
                request.callback = callback
                request.send()
            }
        }

        Button {
            text: qsTr("Get User Data")
            onClicked: {
                request.path = "/V1/user"
                request.body = {}
                request.method = XMLHttpRequestModel.Method.GET
                request.callback = callback
                request.headers['Authorization'] = `Bearer ${conf.userToken}`
                request.send()
            }
        }
        */

        Label {
            id: responseData
            width: parent.width
            wrapMode: Label.WordWrap
        }
    }

    function callback ({ success, data, error }) {
        if (success) {
            if (data)
                responseData.text = (typeof data === 'object') ? JSON.stringify(data, null, 4) : data
        } else {
            if (error)
                responseData.text = (typeof error === 'object') ? JSON.stringify(error, null, 4) : error
        }
    }

    XMLHttpRequestModel {
        id: request
        url: "https://api.myhousethings.com"
//        url: "http://localhost:3000"
        content: XMLHttpRequestModel.Content.APPLICATION_JSON
    }
}
