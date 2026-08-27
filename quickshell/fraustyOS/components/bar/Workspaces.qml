import Quickshell
import Quickshell.Hyprland
import QtQuick

Item {
    id: root

    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    RowLayout {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: 10

            Rectangle {
                required property int index

                // Hyprland uses workspaces 1-10 internally.
                // We display workspace 10 as "0".
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
                        ? "#89b4fa"
                        : "#cdd6f4"

                    font.pixelSize: 13
                    font.weight: Font.Bold

                    scale: parent.focused ? 1.25 : 1.0

                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 100
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