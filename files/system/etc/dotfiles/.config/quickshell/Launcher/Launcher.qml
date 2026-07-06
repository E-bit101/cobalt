import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Wayland
import "../"
import "../Shaders"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            readonly property int panelMargin: 30
            exclusiveZone: 0
            WlrLayershell.namespace: Theme.fluid ? "launcherNoBlur" : "launcher"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

            color: "transparent"

            required property var modelData

            screen: modelData

            anchors {
                bottom: true
            }

            margins {
                bottom: 5
            }

            implicitWidth: 338 + panelMargin
            implicitHeight: 400 + panelMargin

            visible: Theme.launcherVisible

            Rectangle {
                anchors.fill: parent
                anchors.margins: 1

                radius: 11
                color: "transparent"
                border.color: Theme.bgAccent
                border.width: 1
            }

            Fluid {
                anchors.fill: parent

                wallpaper: Qt.resolvedUrl("../Decorations/IMG_1671.png")

                screenSize: Qt.vector2d(
                    modelData.width,
                    modelData.height)

                screenX: mapToGlobal(width, height).x + width / 3 + 12
                screenY: mapToGlobal(width, height).y - height / 3 - 6
                cornerRadius: 0.1
                visible: Theme.fluid
            }

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: Theme.bgPrimary
                visible: !Theme.fluid
            }

            Column {
                id: container
                anchors.fill: parent
                anchors.margins: panelMargin / 2
                spacing: 20

                TextField {
                    id: txt
                    // center the bar in its parent component (the window)
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    focus: true

                    onActiveFocusChanged: {
                        if (!activeFocus)
                            Theme.launcherVisible = false
                    }
                }

                Apps {
                    id: apps
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                }
            }
        }
    }
}