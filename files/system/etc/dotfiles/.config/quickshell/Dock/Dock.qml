import Quickshell
import QtQuick
import Quickshell.Wayland
import "../Widgets"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            WlrLayershell.namespace: "dock"
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
                    color: "#a0323232"
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                }

                height: 48
                color: "#c0000000"

                Row {
                    anchors.centerIn: parent
                    spacing: 10

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: Qt.resolvedUrl("icon.svg")
                        height: 30
                        fillMode: Image.PreserveAspectFit
                    }

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: Qt.resolvedUrl("search.svg")
                        height: 26
                        fillMode: Image.PreserveAspectFit
                    }
                }
                
            }
        }
    }
}