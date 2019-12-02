import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Layouts 1.12

import Qmodules.ImagePicker 1.0
import "qrc:/components"
import "../styles"

NavigationPage {
    id: page
    objectName: "pages/Login"

    width: window.width
    property int columnMaxWidth: page.width > 500 ? 500 : parent.width
    property string pageType: "login"

    //pageType === "login" ? componentLogin : componentRegister

    content: Item {
        Column {
            width: columnMaxWidth
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                onClicked: conf.dark = !conf.dark
                anchors.right: parent.right

                text: conf.dark ? qsTr("Switch to Light") : qsTr("Switch to Dark")
                flat: true
            }
            Item {
                width: parent.width
                height: 100

                Label {
                    text: "2Devs"
                    font.bold: true
                    font.pointSize: 32
                    font.capitalization: Font.AllUppercase
                    anchors.centerIn: parent
                }
            }

            Loader {
                active: pageType === "login"
                visible: active
                width: parent.width
                sourceComponent: Component {
                    Column {
                        width: parent.width
                        padding: 20
                        spacing: 20

                        Item {
                            width: parent.width - (parent.padding * 2)
                            height: 100

                            Rectangle {
                                width: 100
                                height: 100
                                anchors.centerIn: parent

                                color: "transparent"
                                border.color: page.palette.text
                                border.width: 5
                                radius: width / 2

                                Image {
                                    id: userImage
                                    visible: imagePicker.filename
                                    anchors.centerIn: parent
                                    width: 100
                                    height: width
                                    fillMode: Image.PreserveAspectCrop
                                }

                                IconLabel {
                                    visible: !imagePicker.filename
                                    anchors.centerIn: parent
                                    icon.name: "person"
                                    icon.width: 90
                                    icon.color: page.palette.text
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: imagePicker.openPicker()
                                }

                                ImagePicker {
                                    id: imagePicker
                                    onFilenameChanged: {
                                        userImage.source = "file:///" + filename
                                    }
                                }
                            }
                        }

                        CustomTextField {
                            id: emailField
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("E-mail")
                        }

                        CustomTextField {
                            id: passwordField
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("Password")
                            isPassword: true
                        }

                        Button {
                            enabled: emailField.text && passwordField.text
                            width: parent.width - (parent.padding * 2)
                            height: 40
                            text: qsTr("Login")
                            highlighted: true
                        }

                        Button {
                            text: qsTr("Forgot password?")
                            flat: true
                            anchors.right: parent.right
                            anchors.rightMargin:  parent.padding
                            onClicked: pageType = "forgot"
                        }

                        Item {
                            width: parent.width - (parent.padding * 2)
                            height: 100

                            Button {
                                width: parent.width
                                text: qsTr("Create an account")
                                anchors.centerIn: parent

                                onClicked: pageType = "register"
                            }
                        }
                    }
                }
            }
            Loader {
                active: pageType === "register"
                visible: active
                width: parent.width
                sourceComponent: Component {
                    Column {
                        width: parent.width
                        padding: 20
                        spacing: 20

                        Label {
                            width: parent.width - (parent.padding * 2)
                            text: qsTr("Create an account")
                            font.bold: true
                            font.pixelSize: 22
                        }

                        CustomTextField {
                            id: fieldNameRegister
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("Name")
                        }

                        CustomTextField {
                            id: fieldEmailRegister
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("E-mail")
                        }

                        CustomTextField {
                            id: fieldPasswordRegister
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("Password")
                            isPassword: true

                            property alias secure: passwordValidate.secure
                            PasswordValidate {
                                id: passwordValidate
                                visible: fieldPasswordRegister.focus && fieldPasswordRegister.text
                                value: fieldPasswordRegister.text
                            }
                        }

                        SwitchDelegate {
                            id: fieldUserType
                            width: parent.width - (parent.padding * 2)
                            text: qsTr("Are you a developer?")
                            checked: true
                        }

                        Button {
                            enabled: fieldNameRegister.text.length > 5 && validateEmail(fieldEmailRegister.text) && fieldPasswordRegister.secure
                            width: parent.width - (parent.padding * 2)
                            height: 40
                            text: qsTr("Signup")
                            highlighted: true
                        }

                        Item {
                            width: parent.width - (parent.padding * 2)
                            height: 100

                            Button {
                                width: parent.width
                                text: qsTr("Login")
                                icon.name: "arrow-back-ios"
                                anchors.centerIn: parent

                                onClicked: pageType = "login"
                            }
                        }
                    }
                }
            }

            Loader {
                active: pageType === "forgot"
                width: parent.width
                sourceComponent: Component {
                    Column {
                        width: parent.width
                        padding: 20
                        spacing: 20

                        Label {
                            width: parent.width - (parent.padding * 2)
                            text: qsTr("Forgot your password?")
                            font.bold: true
                            font.pixelSize: 22
                        }

                        Label {
                            width: parent.width - (parent.padding * 2)
                            text: qsTr("Enter your email to receive the recovery code")
                        }

                        CustomTextField {
                            id: fieldForgotEmail
                            width: parent.width - (parent.padding * 2)
                            placeholderText: qsTr("E-mail")
                        }

                        Button {
                            enabled: validateEmail(fieldForgotEmail.text)
                            width: parent.width - (parent.padding * 2)
                            height: 40
                            text: qsTr("Send")
                            highlighted: true
                        }

                        Item {
                            width: parent.width - (parent.padding * 2)
                            height: 100

                            Button {
                                width: parent.width
                                text: qsTr("Login")
                                icon.name: "arrow-back-ios"
                                anchors.centerIn: parent

                                onClicked: pageType = "login"
                            }
                        }
                    }
                }
            }
        }
    }

    function validateEmail (email) {
        return /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)
    }
}
