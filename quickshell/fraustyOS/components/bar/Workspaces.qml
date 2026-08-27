import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../../config"

Item {
    id: root

    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    Row {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: 10

            Rectangle {
                required property int index

                property int workspaceId: index === 0 ? 10 : index

                property bool focused:
                    Hyprland.focusedWorkspace !== null
                    && Hyprland.focusedWorkspace.id === workspaceId

                implicitWidth: 26
                implicitHeight: 26

                color: "transparent"

                Text {
                    anchors.centerIn: parent

                    text: index.toString()

                    color: parent.focused
                        ? Appearance.accent
                        : Appearance.foreground

                    font.pixelSize: Appearance.workspaceFontSize
                    font.weight: Font.Bold

                    scale: parent.focused ? 1.25 : 1.0

                    Behavior on scale {
                        NumberAnimation {
                            duration: Appearance.animationFast
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Appearance.animationFast
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        Hyprland.dispatch(
                            "hl.dsp.focus({ workspace = "
                            + parent.workspaceId
                            + " })"
                        )
                    }
                }
            }
        }
    }
}