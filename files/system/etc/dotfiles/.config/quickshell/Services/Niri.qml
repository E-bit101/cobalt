pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var workspaces: []

    Process {
        id: workspaceProcess

        command: ["niri", "msg", "-j", "workspaces"]

        stdout: StdioCollector {
            onStreamFinished: {
                Niri.workspaces = JSON.parse(text)
            }
        }
    }

    function refresh() {
        workspaceProcess.running = true
    }

    Process {
        id: focusProcess
    }

    function focusWorkspace(idx) {
        focusProcess.command = [
            "niri",
            "msg",
            "action",
            "focus-workspace",
            idx.toString()
        ]

        focusProcess.running = true
        refresh()
    }

    Component.onCompleted: refresh()

    Timer {
        interval: 250
        running: true
        repeat: true

        onTriggered: refresh()
    }
}