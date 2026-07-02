import Quickshell
import QtQuick
import Quickshell.Wayland
import "../Widgets"
import "../"

Scope {
    Variants {
        model: Quickshell.screens

        Item {
            required property var modelData

            // Bar
            PanelWindow {
                screen: modelData

                WlrLayershell.namespace: "shellPanel"

                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 32
                exclusiveZone: 32

                Rectangle {
                    anchors.fill: parent
                    color: Theme.bgPrimary

                    Workspaces {
                        screen: modelData

                        anchors {
                            left: parent.left
                            leftMargin: 8
                            verticalCenter: parent.verticalCenter
                        }
                    }

                    ClockWidget {
                        anchors.centerIn: parent
                    }

                    BatteryWidget {
                        anchors {
                            right: parent.right
                            rightMargin: 10
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }

            // Shadow
            PanelWindow {
                screen: modelData

                WlrLayershell.namespace: "shellPanelShadow"

                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 10
                exclusiveZone: 0

                Rectangle {
                    visible: Theme.shadows
                    anchors.fill: parent
                    color: "transparent"

                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#80000000"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#00000000"
                        }
                    }
                }
            }
        }
    }
}