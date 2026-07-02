import QtQuick
import "../Services"

Row {
    id: root

    property var screen

    spacing: 6

    property color activeColor: "#006eff"
    property color inactiveColor: "#444444"
    property color hoverColor: "#5a5a5a"

    add: Transition {
        NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 160 }
        NumberAnimation {
            properties: "scale"
            from: 0.4; to: 1
            duration: 220
            easing.type: Easing.OutBack
            easing.overshoot: 4
        }
    }

    // Same fade-in on first load
    populate: Transition {
        NumberAnimation { properties: "opacity"; from: 0; to: 1; duration: 160 }
    }

    move: Transition {
        NumberAnimation { properties: "x,y"; duration: 180; easing.type: Easing.OutCubic }
    }

    Repeater {
        model: Compositor.workspaces
            .filter(ws => ws.output === root.screen.name)
            .sort((a, b) => a.idx - b.idx)

        Rectangle {
            id: pill

            required property var modelData

            readonly property bool active: modelData.is_active

            width: active ? 30 : 16
            height: 16
            radius: height / 2

            color: active
                ? root.activeColor
                : (hover.hovered ? root.hoverColor : root.inactiveColor)

            Behavior on width {
                NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            // Quick press feedback.
            scale: tap.pressed ? 0.88 : 1
            Behavior on scale {
                NumberAnimation { duration: 90; easing.type: Easing.OutQuad }
            }

            Text {
                anchors.centerIn: parent
                text: pill.modelData.idx
                color: "#ffffff"
                opacity: pill.active ? 1 : 0.75
                font.pixelSize: 11

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
            }

            HoverHandler {
                id: hover
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                id: tap
                onTapped: Compositor.focusWorkspace(pill.modelData.idx)
            }
        }
    }
}
