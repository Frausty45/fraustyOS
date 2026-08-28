import Quickshell
import QtQuick
import QtQuick.Controls
import "../config"

PopupWindow {
    id: root

    property Item anchorItem
    anchor.item: anchorItem

    anchor {
        edges: Edges.Bottom
        gravity: Edges.Bottom
    }

    implicitWidth: 420
    implicitHeight: 500

    visible: false
    grabFocus: true

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        color: Appearance.background
        radius: 12

        border.width: 1
        border.color: Appearance.foreground

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            Text {
                text: "Applications"

                color: Appearance.foreground

                font.pixelSize: 17
                font.weight: Font.Bold
            }

            ListView {
                id: appList

                width: parent.width
                height: parent.height - 40

                clip: true
                spacing: 4

                model: DesktopEntries.applications.values

                delegate: Rectangle {
                    required property var modelData

                    width: appList.width
                    height: 42
                    radius: 7

                    color: mouseArea.containsMouse
                        ? Appearance.accent
                        : "transparent"

                    Text {
                        anchors {
                            left: parent.left
                            leftMargin: 12
                            verticalCenter: parent.verticalCenter
                        }

                        text: modelData.name
                        color: Appearance.foreground

                        font.pixelSize: 14
                        font.weight: Font.Bold
                    }

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            modelData.execute()
                            root.visible = false
                        }
                    }
                }
            }
        }
    }
}