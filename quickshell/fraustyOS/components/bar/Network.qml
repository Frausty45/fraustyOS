import Quickshell
import Quickshell.Networking
import QtQuick

import "../../config"

Item {
    id: root

    property bool ethernetConnected: {
        const devices = Networking.devices.values

        for (let i = 0; i < devices.length; i++) {
            const device = devices[i]

            if (device.type === DeviceType.Wired && device.connected)
                return true
        }

        return false
    }

    property bool wifiConnected: {
        const devices = Networking.devices.values

        for (let i = 0; i < devices.length; i++) {
            const device = devices[i]

            if (device.type === DeviceType.Wifi && device.connected)
                return true
        }

        return false
    }

    implicitWidth: networkText.implicitWidth
    implicitHeight: networkText.implicitHeight

    Text {
        id: networkText
        anchors.centerIn: parent

        text: {
            if (root.ethernetConnected)
                return "ETH"

            if (root.wifiConnected)
                return "ᯤ"

            return "Ø"
        }

        color: Appearance.foreground

        font.pixelSize: Appearance.fontSize
        font.weight: Font.Bold
    }
}