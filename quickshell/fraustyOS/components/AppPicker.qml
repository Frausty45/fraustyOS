import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "../config"

PanelWindow {
    id: root

    property Item anchorItem

    anchors {
        top: true
        left: true
    }

    margins {
        top: 48
        left: 12
    }

    implicitWidth: 420
    implicitHeight: 500

    visible: false
    focusable: true

    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    HyprlandFocusGrab {
        id: focusGrab

        windows: [root]
        active: root.visible

        onCleared: {
            root.visible = false
        }
    }

    onVisibleChanged: {
        if (visible) {
            searchField.text = ""
            appList.currentIndex = 0
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

                onTextChanged: {
                    calculatorDebounce.restart()
                    appList.currentIndex = 0
                }

                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Down) {
                        if (appList.count > 0) {
                            appList.currentIndex = Math.min(
                                appList.currentIndex + 1,
                                appList.count - 1
                            )
                            appList.positionViewAtIndex(
                                appList.currentIndex,
                                ListView.Contain
                            )
                        }

                        event.accepted = true
                    }

                    else if (event.key === Qt.Key_Up) {
                        if (appList.count > 0) {
                            appList.currentIndex = Math.max(
                                appList.currentIndex - 1,
                                0
                            )
                            appList.positionViewAtIndex(
                                appList.currentIndex,
                                ListView.Contain
                            )
                        }

                        event.accepted = true
                    }

                    else if (
                        event.key === Qt.Key_Return ||
                        event.key === Qt.Key_Enter
                    ) {
                        if (appList.currentIndex >= 0) {
                            const app = appList.model[appList.currentIndex]

                            if (app) {
                                app.execute()
                                root.visible = false
                            }
                        }

                        event.accepted = true
                    }

                    else if (event.key === Qt.Key_Escape) {
                        root.visible = false
                        event.accepted = true
                    }
                }
            }

            Rectangle {
                id: calculatorResultBox

                width: parent.width
                height: visible ? 52: 0

                visible: root.calculatorResult.length > 0

                radius: 7

                color: calculatorMouse.containsMouse
                    ? Appearance.accent
                    : "transparent"

                Text {
                    anchors {
                        left: parent.left
                        leftMargin: 12

                        right: parent.right
                        rightMargin: 12

                        verticalCenter: parent.verticalCenter
                    }

                    text: root.calculatorResult

                    color: Appearance.foreground

                    font.pixelSize: 16
                    font.weight: Font.Bold

                    elide: Text.ElideRight
                }

                MouseArea {
                    id: calculatorMouse

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        Quickshell.clipboardText = root.calculatorResult
                    }
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
                    id: appDelegate

                    required property var modelData

                    width: appList.width
                    height: 42
                    radius: 7

                    color: mouseArea.containsMouse || ListView.isCurrentItem
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

    property string calculatorResult: ""
    property string calculatorExpression: ""

    function looksLikeCalculation(text) {
        const query = text.trim()

        if (query.length === 0)
            return false

        // explicit calc mode
        if (query.startsWith("="))
            return true

        // dont send normal app searches to calc
        if (!/\d/.test(query))
            return false

        // arithmetic
        if (/[+\-*/\^%=()]/.test(query))
            return true

        // conversion / calc language
        if (/\b(to|in|of)\b/i.test(query))
            return true

        // common functions
        if (/\b(sqrt|sin|cos|tan|asin|acos|atan|log|ln|exp|abs\b/i.test(query))
            return true

        return false
    }

    function runCalculation() {
        let expression = searchField.text.trim()

        if (expression.startsWith("="))
            expression = expression.substring(1).trim()

        if (!looksLikeCalculation(searchField.text)) {
            calculatorResult = ""
            calculatorExpression = ""
            return
        }

        calculatorExpression = expression

        if (calculator.running)
            calculator.running = false

        const percentOfMatch = expression.match(
            /^\s*(-?\d+(?:\.\d+)?)\s*%\s+of\s+(-?\d+(?:\.\d+)?)\s*$/i
        )

        if (percentOfMatch) {
            expression =
                "(" + percentOfMatch[1] + " / 100) * " + percentOfMatch[2]
        }

        calculator.command = [
            "qalc",
            "--terse",
            "--time",
            "1000",
            expression
        ]

        calculator.running = true
    }

    Process {
        id: calculator

        stdout: StdioCollector {
            onStreamFinished: {
                const result = text.trim()

                if (result.length > 0)
                    root.calculatorResult = result
                else
                    root.calculatorResult = ""
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {
                // invalid calc input = no result
                if (text.trim().length > 0)
                    root.calculatorResult = ""
            }
        }
    }

    Process {
        id: exchangeRateUpdater

        command: [
            "qalc",
            "--exrates"
        ]
    }

    Timer {
        id: exchangeRateTimer

        interval: 12 * 60 * 60 * 1000
        repeat: true
        running: true

        onTriggered: {
            if (!exchangeRateUpdater.running)
                exchangeRateUpdater.running = true
        }
    }

    Timer {
        id: calculatorDebounce

        interval: 180
        repeat: false

        onTriggered: root.runCalculation()
    }

    Component.onCompleted: {
        exchangeRateUpdater.running = true
    }
}