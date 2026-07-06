import Quickshell
import QtQuick
import Quickshell.Wayland
import "../Widgets"
import "../Shaders"
import "../"

Scope {
    Variants {
        model: Quickshell.screens

        Item {
            required property var modelData

            PanelWindow {
                WlrLayershell.namespace: Theme.fluid ? "shellPanelNoBlur" : "shellPanel"
                screen: modelData

                color: "transparent"

                margins {
                    top: Theme.floatingBar ? 5 : 0
                    left: Theme.floatingBar ? 5 : 0
                    right: Theme.floatingBar ? 5 : 0
                }

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 32
                exclusiveZone: 32

                Item {
                    anchors.fill: parent

                    Rectangle {
                        anchors.fill: parent
                        color: Theme.bgPrimary
                        visible: !Theme.fluid
                    }

                    Fluid {
                        anchors.fill: parent

                        wallpaper: Qt.resolvedUrl("../Decorations/IMG_1671.png")

                        screenSize: Qt.vector2d(
                            modelData.width,
                            modelData.height)

                        screenX: 5
                        screenY: 5
                        visible: Theme.fluid
                    }

                    Workspaces {
                        screen: modelData
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    ClockWidget {
                        anchors.centerIn: parent
                    }

                    BatteryWidget {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}