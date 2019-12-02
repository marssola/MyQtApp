import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0

T.TextField {
    id: control

    property bool isPassword: false

    onIsPasswordChanged: control.echoMode = isPassword ? TextField.Password : TextField.Normal

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4
    rightPadding: padding + 4 + (isPassword ? iconRight.width : 0)

    color: control.palette.text
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText
    placeholderTextColor: Color.transparent(control.color, 0.5)
    verticalAlignment: TextInput.AlignVCenter

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: control.palette.base
        radius: implicitHeight * 0.20
        opacity: 0.75

        IconLabel {
            id: iconRight
            property bool showPassword: false
            onShowPasswordChanged: control.echoMode = showPassword ? TextField.Normal : TextField.Password
            visible: control.isPassword
            width: 25
            icon.width: width
            icon.name: showPassword ? "hide-password" : "show-password"
            icon.color: control.placeholderTextColor
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: (parent.height / 2) - (height / 2)

            MouseArea {
                anchors.fill: parent
                onClicked: parent.showPassword = !parent.showPassword
            }
        }
    }
}
