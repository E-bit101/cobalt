pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

// Unified workspace source for Hyprland and niri.
Singleton {
    id: root

    readonly property bool isHyprland: Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE") !== null
    readonly property bool isNiri: !isHyprland && Quickshell.env("NIRI_SOCKET") !== null

    readonly property var workspaces: {
        if (isHyprland) {
            return Hyprland.workspaces.values.map(ws => ({
                idx: ws.id,
                output: ws.monitor ? ws.monitor.name : "",
                is_active: ws.active
            }))
        }

        if (isNiri) return niriWorkspaces

        return []
    }

    function focusWorkspace(idx) {
        if (isHyprland) {
            Hyprland.dispatch("workspace " + idx)
        } else if (isNiri) {
            niriFocusProcess.command = ["niri", "msg", "action", "focus-workspace", idx.toString()]
            niriFocusProcess.running = true
        }
    }

    // ---- niri backend ----

    property var niriWorkspaces: []

    Process {
        id: niriWorkspacesProcess
        command: ["niri", "msg", "-j", "workspaces"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    root.niriWorkspaces = JSON.parse(text)
                } catch (e) {
                    // niri gave us something unparsable; keep the last
                    // known-good list instead of blanking the bar out.
                }
            }
        }
    }

    Process {
        id: niriFocusProcess
    }

    Process {
        id: niriEventStream
        running: root.isNiri
        command: ["niri", "msg", "-j", "event-stream"]

        stdout: SplitParser {
            onRead: data => niriRefreshDebounce.restart()
        }
    }

    Timer {
        id: niriRefreshDebounce
        interval: 10
        repeat: false
        onTriggered: niriWorkspacesProcess.running = true
    }

    Component.onCompleted: {
        if (isNiri) niriWorkspacesProcess.running = true
    }
}
