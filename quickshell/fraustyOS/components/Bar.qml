import Quickshell
import QtQuick
import "bar"
import "../config"

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Appearance.barHeight
    exclusiveZone: Appearance.barHeight

    Rectangle {
        anchors.fill: parent
        color: Appearance.background

        Text {
            anchors.centerIn: parent

            text: "fraustyOS"
            color: Appearance.foreground

            font.pixelSize: Appearance.fontSize
            font.weight: Font.Bold
        }

        Clock {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: Appearance.barMargin
            }
        }

        Workspaces {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: Appearance.barMargin
            }
        }
    }
}