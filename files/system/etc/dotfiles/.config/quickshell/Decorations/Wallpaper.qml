import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Component {
            Scope {
                required property var modelData

                // Normal desktop wallpaper
                PanelWindow {
                    screen: modelData

                    WlrLayershell.layer: WlrLayer.Background
                    WlrLayershell.namespace: "wallpaper"

                    exclusionMode: ExclusionMode.Ignore

                    anchors {
                        top: true
                        bottom: true
                        left: true
                        right: true
                    }

                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl("temp-wallpaper.svg")
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                // Wallpaper used by the overview backdrop
                PanelWindow {
                    screen: modelData

                    WlrLayershell.layer: WlrLayer.Background
                    WlrLayershell.namespace: "overview-wallpaper"

                    exclusionMode: ExclusionMode.Ignore

                    anchors {
                        top: true
                        bottom: true
                        left: true
                        right: true
                    }

                    Image {
                        anchors.fill: parent
                        source: Qt.resolvedUrl("temp-overview-wallpaper.svg")
                        fillMode: Image.PreserveAspectCrop
                    }
                }
            }
        }
    }
}