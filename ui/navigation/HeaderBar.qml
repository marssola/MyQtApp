import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "qrc:/components"

HeaderBar {
    id: headerBar
    property string title
    property string subtitle

    height: 50

    RowLayout {
        id: rowContainer
        anchors.fill: parent

        Label {
            text: headerBar.title
            font.bold: true

            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 10

            verticalAlignment: Label.AlignVCenter
            font.pixelSize: 18
            wrapMode: Label.WordWrap
            elide: Label.ElideRight
        }

        ToolButton {
            icon.name: "more-vert"
            icon.width: 20

            Layout.preferredWidth: 40
            onClicked: loaderDialog.item.open()
        }
    }
}

