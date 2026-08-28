import Quickshell
import Quickshell.Hyprland
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

    GlobalShortcut {
        name: "appPicker"
        description: "Toggle fraustyOS app picker"

        onPressed: {
            appPicker.visible = !appPicker.visible
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Appearance.background

        Item {
            id: brandButton

            anchors.centerIn: parent

            width: brand.implicitWidth
            height: parent.height

            Text {
                id: brand
                anchors.centerIn: parent

                text: "fraustyOS"

                color: brandMouse.containsMouse
                    ? Appearance.accent
                    : Appearance.foreground

                font.pixelSize: Appearance.fontSize
                font.weight: Font.Bold

                Behavior on color {
                    ColorAnimation {
                        duration: Appearance.animationFast
                    }
                }
            }

            MouseArea {
                id: brandMouse

                anchors.fill: parent

                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    appPicker.visible = !appPicker.visible
                }
            }
        }

        AppPicker {
            id: appPicker
            anchorItem: brandButton
        }

        Battery {
            anchors {
                right: brandButton.left
                verticalCenter: parent.verticalCenter
                rightMargin: 14
            }
        }

        Network {
            anchors {
                left: brandButton.right
                verticalCenter: parent.verticalCenter
                leftMargin: 14
            }
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