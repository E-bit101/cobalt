import QtQuick

Item {
    id: root

    property url wallpaper
    property vector2d screenSize

    property real screenX: x
    property real screenY: y

    property real time: 0

    // Liquid-glass tuning knobs
    property real cornerRadius: 1
    property real blurStrength: 2
    property real refractionStrength: 10
    property real gamma: 0.6

    NumberAnimation on time {
        from: 0
        to: 1000
        duration: 1000000
        loops: Animation.Infinite
    }

    Image {
        id: wallpaperTexture
        source: root.wallpaper
        visible: false
    }

    ShaderEffect {
        anchors.fill: parent

        property variant wallpaper: wallpaperTexture

        property vector2d screenSize:
            root.screenSize

        property vector2d panelPos:
            Qt.vector2d(
                root.screenX,
                root.screenY)

        property vector2d panelSize:
            Qt.vector2d(width, height)

        property real time:
            root.time

        property real cornerRadius:
            root.cornerRadius

        property real blurStrength:
            root.blurStrength

        property real refractionStrength:
            root.refractionStrength

        property real gamma:
            root.gamma

        vertexShader:
            "Fluid.vert.qsb"

        fragmentShader:
            "Fluid.frag.qsb"
    }
}