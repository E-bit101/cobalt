import Quickshell
import QtQuick
import "../Widgets"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            color: "transparent"
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 42
            exclusiveZone: 32

            Rectangle {
                id: bar

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                height: 32
                color: "#000000"

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

            Rectangle {
                anchors {
                    top: bar.bottom
                    left: bar.left
                    right: bar.right
                }

                height: 10
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