import QtQuick 2.12
import QtQuick.Controls 2.12

TabBar {
    id: footer

    property alias model: repeater.model
    property int iconPosition: (width / repeater.model.count) < 200 ? TabButton.IconOnly : TabButton.TextBesideIcon

    Repeater {
        id: repeater

        TabButton {
            text: name
            icon.name: iconName
            font.pixelSize: 14
            display: footer.iconPosition
            onClicked: stackView.setPage(page)
        }
    }
}
