import Quickshell
import QtQuick
import Quickshell.Wayland
import "../Widgets"
import "../"
import "../Launcher"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            visible: Theme.dockEnabled
            WlrLayershell.namespace: "shellPanel"
            color: "transparent"
            required property var modelData

            screen: modelData

            anchors {
                bottom: true
                left: true
                right: true
            }

            implicitHeight: 48
            exclusiveZone: 48

            Rectangle {
                id: bar

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Rectangle {
                    height: 1
                    color: Theme.bgAccent
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                }

                height: 48
                color: Theme.bgPrimary

                Row {
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
}