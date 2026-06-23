import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData

                // Put this window on the current monitor
                screen: modelData

                // Behind everything
                WlrLayershell.layer: WlrLayer.Background
                exclusionMode: ExclusionMode.Ignore

                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }

                color: "transparent"

                Image {
                    anchors.fill: parent

                    source: "file:///home/youruser/Pictures/wallpaper.svg"

                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    asynchronous: true
                }
            }
        }
    }
}