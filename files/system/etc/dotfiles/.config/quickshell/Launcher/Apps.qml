import Quickshell
import QtQuick
import "../Services"
import "../"


Grid {
    id: root

    property var screen
    
    property int cellSize: 80
    spacing: 6

    columns: Math.max(
        1,
        Math.floor((width + spacing) / (cellSize + spacing))
    )

    Repeater {

        model: DesktopEntries.applications

        Rectangle {
            id: pill

            required property var modelData

            width: parent.cellSize
            height: parent.cellSize
            radius: 8

            color: "#06FFFFFF"

            Column {
                anchors.centerIn: parent
                spacing: 2

                Rectangle {
                    radius: 6
                    width: parent.parent.width / 1.8
                    height: parent.parent.height / 1.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: Theme.bgAccent

                    Image {
                        id: img
                        source: "image://icon/" + pill.modelData.icon
                        anchors.centerIn: parent
                        width: parent.width - 8
                        height: parent.height - 8
                    }
                }

                Text {
                    function limitString(str) {
                        var length = 12
                        if (str.length > length) {
                            return str.slice(0, length-3) + "..."
                        }
                        return str
                    }
                    text: limitString(pill.modelData.name)
                    color: "#FFFFFF"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            HoverHandler {
                id: hover
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                id: tap
                onTapped: pill.modelData.execute()
            }
        }
    }
}
