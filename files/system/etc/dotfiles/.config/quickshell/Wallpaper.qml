import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

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

                    source: "temp-wallpaper.svg"

                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                    asynchronous: true
                }
            }
        }
    }
}