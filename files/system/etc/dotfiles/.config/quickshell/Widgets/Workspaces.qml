import QtQuick
import "../Services"

Row {
    id: root

    property var screen

    spacing: 6

    Repeater {
        model: Niri.workspaces.filter(
            ws => ws.output === root.screen.name
        ).sort((a, b) => a.idx - b.idx)

        Rectangle {
            required property var modelData

            width: 24
            height: 16
            radius: 8

            color: modelData.is_active
                ? "#ffffff"
                : "#444444"

            Text {
                anchors.centerIn: parent

                text: modelData.idx

                color: modelData.is_active
                    ? "#000000"
                    : "#ffffff"
            }

            TapHandler {
                onTapped: {
                    Niri.focusWorkspace(modelData.idx)
                }
            }
        }
    }
}