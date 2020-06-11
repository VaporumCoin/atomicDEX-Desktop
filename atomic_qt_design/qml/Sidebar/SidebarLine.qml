import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import QtGraphicalEffects 1.0
import "../Components"
import "../Constants"

Item {
    property int dashboard_index
    property alias image: img.source
    property alias text: txt.text
    property alias separator: separator.visible
    readonly property bool selected: dashboard.current_page === dashboard_index

    function toggleDarkUI() {
        Style.dark_theme = !Style.dark_theme
    }

    height: Style.sidebarLineHeight

    Switch {
        visible: dashboard_index === General.idx_dashboard_light_ui
        anchors.left: parent.left
        anchors.leftMargin: img.anchors.leftMargin * 0.5
        anchors.verticalCenter: img.verticalCenter
        scale: 0.5
        //onCheckedChanged: toggleDarkUI()
        checked: Style.dark_theme
    }

    Image {
        id: img
        height: txt.font.pixelSize * 1.4
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.verticalCenter: parent.verticalCenter
        visible: false
    }
    ColorOverlay {
        visible: img.source != ""
        anchors.fill: img
        source: img
        color: txt.font.bold ? Style.colorSidebarIconHighlighted : txt.color
    }

    DefaultText {
        id: txt
        anchors.right: parent.right
        anchors.rightMargin: img.anchors.leftMargin
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: Style.textSizeSmall1
        font.weight: selected ? Font.Bold : Font.Medium
        color: font.bold ? Style.colorWhite1 : mouse_area.containsMouse ? Style.colorThemePassiveLight : Style.colorThemePassive
    }

    MouseArea {
        id: mouse_area
        hoverEnabled: true
        width: parent.width
        height: parent.height
        onClicked: function() {
            if(dashboard_index === General.idx_dashboard_light_ui) {
                toggleDarkUI()
            }
            else dashboard.current_page = dashboard_index
        }
    }

    Separator {
        id: separator
        anchors.horizontalCenter: parent.horizontalCenter
    }
}




