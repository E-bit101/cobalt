pragma Singleton
import QtQuick

QtObject {
    // Misc
    property bool shadows: false

    // Colors
    //property color bgPrimary: "#000000"
    property color bgPrimary: "#c0000000"
    property color bgSecondary: "#c0444444"
    property color bgAccent: "#10ffffff"

    property color accent: "#006eff"
    property color textColor: "#ffffff"
    
    // Dock
    property bool dockEnabled: true

    property bool launcherVisible: false

    property bool floatingDock: false
    property bool floatingBar: false
    property bool fluid: false
}