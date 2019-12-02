import QtQuick 2.12
import QtQuick.Controls 2.12

Dialog {
    width: window.width > 300 ? 300 : window.width * 0.95
    height: 150
    x: (window.width - width) / 2
    y: (window.height - height) / 2 - (window.header ? window.header.height : 0)
    modal: true

    title: qsTr("App Style")

    Column {
        id: column
        width: parent.width

        SwitchDelegate {
            width: parent.width
            text: qsTr("Dark Mode")
            checked: conf.dark
            onCheckedChanged: conf.dark = checked
        }
    }
}
