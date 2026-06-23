pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import "../Services"

Singleton {
    property int percent: 0
    property string status: "Unknown"

    Process {
        id: capacityProcess

        command: [
            "cat",
            "/sys/class/power_supply/BAT0/capacity"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                Battery.percent = parseInt(text.trim())
            }
        }

        running: true
    }

    Process {
        id: statusProcess

        command: [
            "cat",
            "/sys/class/power_supply/BAT0/status"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                Battery.status = text.trim()
            }
        }

        running: true
    }

    function refresh() {
        capacityProcess.running = true
        statusProcess.running = true
    }

    Timer {
        interval: 3
        running: true
        repeat: true

        onTriggered: refresh()
    }
}