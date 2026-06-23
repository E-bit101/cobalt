import QtQuick

import "../Services"

Text {
    text: Battery.percent + "%"
    color: Battery.percent < 20
        ? "red"
        : Battery.status == "Charging"
            ? "#5fff5f"
            : Battery.status == "Not charging"
                ? "#006eff"
                : "white"
}