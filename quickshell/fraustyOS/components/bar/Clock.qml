import Quickshell
import QtQuick
import "../../config"

Item {
    id: root

    implicitWidth: clockText.implicitWidth
    implicitHeight: clockText.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        id: clockText
        anchors.centerIn: parent

        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Appearance.foreground

        font.pixelSize: Appearance.fontSize
        font.weight: Font.Bold
    }
}