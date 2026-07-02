import QtQuick
import Quickshell.Services.UPower

import "../Services"

Text {
    id: root

    property color normalColor: "#ffffff"
    property color chargingColor: "#5fff5f"
    property color pluggedColor: "#006eff"
    property color lowColor: "#ff5f5f"

    visible: Battery.available
    text: Battery.percent + "%"

    color: {
        if (Battery.isLow) return lowColor
        if (Battery.isCharging) return chargingColor
        if (Battery.state === UPowerDeviceState.PendingCharge) return pluggedColor
        return normalColor
    }

    Behavior on color {
        ColorAnimation { duration: 200 }
    }
}
