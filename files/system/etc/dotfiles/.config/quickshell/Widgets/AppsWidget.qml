import Quickshell
import QtQuick
import "../Services"
import "../"

Row {
    id: root

    property var screen
    spacing: 6

    property Item tooltipTarget: null
    property Item pendingTooltipTarget: null
    property string tooltipText: ""

    function requestTooltip(item, text) {
        pendingTooltipTarget = item
        tooltipText = text
        tooltipDelay.restart()
    }

    function cancelTooltip(item) {
        if (pendingTooltipTarget === item) {
            pendingTooltipTarget = null
            tooltipDelay.stop()
        }
        if (tooltipTarget === item) {
            tooltipTarget = null
        }
    }

    Timer {
        id: tooltipDelay
        interval: 350
        repeat: false
        onTriggered: root.tooltipTarget = root.pendingTooltipTarget
    }

    Repeater {

        model: DesktopEntries.applications

        Rectangle {
            id: pill

            required property var modelData

            width: 32
            height: 32
            radius: height / 2

            color: "transparent"

            Image {
                id: img
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                source: "image://icon/" + pill.modelData.icon
                width: 28
                height: 28
            }

            HoverHandler {
                id: hover
                cursorShape: Qt.PointingHandCursor

                onHoveredChanged: {
                    if (hovered) {
                        root.requestTooltip(pill, pill.modelData.name)
                    } else {
                        root.cancelTooltip(pill)
                    }
                }
            }

            TapHandler {
                id: tap
                onTapped: pill.modelData.execute()
            }
        }
    }

    PopupWindow {
        id: tooltipWindow

        visible: root.tooltipTarget !== null
        color: Theme.bgPrimary

        implicitWidth: tooltipLabel.implicitWidth + 16
        implicitHeight: tooltipLabel.implicitHeight + 10

        anchor {
            item: root.tooltipTarget ?? root
            edges: Edges.Bottom
            gravity: Edges.Top
            margins.bottom: 96
            adjustment: PopupAdjustment.Slide
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: Theme.bgAccent
            border.width: 1

            Text {
                id: tooltipLabel
                anchors.centerIn: parent
                text: root.tooltipText
                color: "#ffffff"
                font.pixelSize: 12
            }
        }
    }
}
