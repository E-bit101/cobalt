import QtQuick

import "../Services"

Text {
    text: Battery.percent + "%"
    color: Battery.percent < 20
        ? "red"
        : Battery.status == "Charging"
            ? "green"
            : Battery.status == "Not charging"
                ? "blue"
                : "white"
}