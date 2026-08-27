import Quickshell
import QtQuick
import "bar"

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 38
    exclusiveZone: 38

    Rectangle {
        anchors.fill: parent
        color: "#181825"

        Text {
            anchors.centerIn: parent

            text: "fraustyOS"
            color: "#cdd6f4"

            font.pixelSize: 15
            font.weight: Font.Bold
        }

        Clock {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 14
            }
        }

        Workspaces {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 14
            }
        }
    }
}