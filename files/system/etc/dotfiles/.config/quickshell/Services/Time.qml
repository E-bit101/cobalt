pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
    id: root
        
    // an expression can be broken across multiple lines using {}
    readonly property string time: {
        // The passed format string matches the default output of
        // the `date` command.
        Qt.formatDateTime(clock.date, "hh:mm:ss AP ddd, MMM dd yyyy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}