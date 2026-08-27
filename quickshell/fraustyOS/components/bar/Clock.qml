import Quickshell
import QtQuick

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
        color: "#cdd6f4"

        font.pixelSize: 15
        font.weight: Font.Medium
    }
}