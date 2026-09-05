import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "components"

ShellRoot {
    id: root

    Variants {
        id: bars

        model: Quickshell.screens

        delegate: Bar {
            required property var modelData

            screen: modelData

            property var hyprMonitor: Hyprland.monitorFor(modelData)
        }
    }

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            const focused = Hyprland.focusedMonitor

            if (!focused)
                return

            const instances = bars.instances

            for (let i = 0; i < instances.length; i++) {
                const bar = instances[i]

                if (bar.hyprMonitor === focused) {
                    bar.togglePicker()
                    return
                }
            }
        }

        function open(): void {
            const focused = Hyprland.focusedMonitor

            if (!focused)
                return

            const instances = bars.instances

            for (let i = 0; i < instances.length; i++) {
                const bar = instances[i]

                if (bar.hyprMonitor === focused) {
                    bar.openPicker()
                    return
                }
            }
        }

        function close(): void {
            const instances = bars.instances

            for (let i = 0; i < instances.length; i++)
                instances[i].closePicker()
        }
    }
}