import Quickshell
import QtQuick
import "./Widgets"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 32

            Rectangle {
                anchors.fill: parent
                color: "#202020"

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
    }
}