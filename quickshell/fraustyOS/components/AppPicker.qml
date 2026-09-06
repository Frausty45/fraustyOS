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

    onVisibleChanged: {
        if (visible) {
            searchField.text = ""
            searchField.forceActiveFocus()
        }
    }

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

            TextField {
                id: searchField

                width: parent.width

                placeholderText: "Search..."
                placeholderTextColor: Appearance.foreground

                color: Appearance.foreground
                font.pixelSize: 14
                font.weight: Font.Medium

                background: Rectangle {
                    color: "transparent"
                    radius: 7

                    border.width: 1
                    border.color: Appearance.foreground
                }
            }

            ListView {
                id: appList

                width: parent.width
                height: parent.height - 40

                clip: true
                spacing: 4

                model: {
                    const query = searchField.text.trim().toLowerCase()

                    return [...DesktopEntries.applications.values]
                        .filter(app => {
                        if (!app.name)
                            return false

                        if (query === "")
                            return true

                        const name = app.name.toLowerCase()
                        const comment = (app.comment || "").toLowerCase()

                        return name.includes(query)
                            || comment.includes(query)
                    })
                        .sort((a, b) =>
                        a.name.localeCompare(
                            b.name,
                            undefined,
                            { sensitivity: "base" }
                        )
                    )
                }

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