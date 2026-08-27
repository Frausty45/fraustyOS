import Quickshell
import Quickshell.Services.UPower
import QtQuick

import "../../config"

Item {
    id: root

    property var battery: UPower.displayDevice

    property bool hasBattery:
        battery !== null
        && battery.ready
        && battery.isLaptopBattery

    property int percentage:
        hasBattery
            ? Math.round(battery.percentage * 100)
            : 0

    implicitWidth: batteryText.implicitWidth
    implicitHeight: batteryText.implicitHeight

    visible: hasBattery

    Text {
        id: batteryText
        anchors.centerIn: parent

        text: root.percentage + "%"

        color: Appearance.foreground

        font.pixelSize: Appearance.fontSize
        font.weight: Font.Bold
    }
}