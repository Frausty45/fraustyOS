pragma Singleton

import QtQuick

QtObject {
    // Colors
    readonly property color background: "#181825"
    readonly property color foreground: "#cdd6f4"
    readonly property color accent:     "#89b4fa"

    // Bar
    readonly property int barHeight: 38
    readonly property int barMargin: 14

    // Typography
    readonly property int fontSize: 15
    readonly property int workspaceFontSize: 13

    // Animation
    readonly property int animationFast: 100
}