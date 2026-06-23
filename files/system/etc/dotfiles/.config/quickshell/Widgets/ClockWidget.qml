import QtQuick
import "../Services"

Text {
    // we no longer need time as an input
    color: '#ffffff'
    // directly access the time property from the Time singleton
    text: Time.time
}