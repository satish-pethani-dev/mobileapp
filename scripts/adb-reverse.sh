#!/usr/bin/env bash
# Forward laptop backend (port 4000) to USB-connected Android device.
set -e
adb reverse tcp:4000 tcp:4000
echo "Done. On your phone set Backend URL to: http://127.0.0.1:4000"
adb reverse --list
