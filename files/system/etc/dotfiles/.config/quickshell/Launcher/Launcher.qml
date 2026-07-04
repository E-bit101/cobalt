import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Wayland
import "../"

PanelWindow {
    readonly property int panelMargin: 30
    exclusiveZone: 0
    WlrLayershell.namespace: "launcher"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    color: "transparent"

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

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: Theme.bgPrimary

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