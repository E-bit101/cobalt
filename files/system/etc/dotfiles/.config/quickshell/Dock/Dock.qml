import Quickshell
import QtQuick
import Quickshell.Wayland
import "../Widgets"
import "../"
import "../Launcher"
import "../Shaders"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            margins {
                bottom: Theme.floatingDock ? 5 : 0
            }

            visible: Theme.dockEnabled
            WlrLayershell.namespace: Theme.fluid ? "shellPanelNoBlur" : "shellPanel"
            color: "transparent"
            required property var modelData

            screen: modelData

            anchors {
                bottom: true
                left: !Theme.floatingDock
                right: !Theme.floatingDock
            }

            implicitHeight: 48
            exclusiveZone: 48
            implicitWidth: 570

            Rectangle {
                height: 1
                color: Theme.bgAccent
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                visible: !Theme.floatingDock
            }

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

                screenX: (modelData.width - 570) / 2
                screenY: modelData.height - 48 - 5
                cornerRadius: 0.7
                visible: Theme.fluid
            }

            Row {
                id: stuffs
                anchors.centerIn: parent
                spacing: 16

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: Qt.resolvedUrl("icon.svg")
                    height: 30
                    fillMode: Image.PreserveAspectFit

                    HoverHandler {
                        id: hover
                        cursorShape: Qt.PointingHandCursor
                    }

                    TapHandler {
                        onTapped: {
                            Theme.launcherVisible = !Theme.launcherVisible
                        }
                    }
                }

                AppsWidget {}
            }
        }
    }
}