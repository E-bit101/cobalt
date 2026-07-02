pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property UPowerDevice device: UPower.displayDevice

    // False on desktops/machines that don't report a laptop battery so
    // widgets can hide themselves instead of showing a stale "0%"
    readonly property bool available: device.ready && device.isLaptopBattery

    readonly property int percent: available ? Math.round(device.percentage * 100) : 0
    readonly property int state: device.state

    readonly property bool isCharging: state === UPowerDeviceState.Charging
    readonly property bool isFullyCharged: state === UPowerDeviceState.FullyCharged
    readonly property bool isLow: available && !isCharging && percent <= 20

    readonly property string status: {
        switch (state) {
        case UPowerDeviceState.Charging: return "Charging"
        case UPowerDeviceState.Discharging: return "Discharging"
        case UPowerDeviceState.FullyCharged: return "Full"
        case UPowerDeviceState.PendingCharge: return "Not charging"
        case UPowerDeviceState.PendingDischarge: return "Pending discharge"
        case UPowerDeviceState.Empty: return "Empty"
        default: return "Unknown"
        }
    }
}
