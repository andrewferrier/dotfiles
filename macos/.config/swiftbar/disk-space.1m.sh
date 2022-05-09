#!/usr/bin/env sh
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

set -o nounset
set -o errexit

"${HOME}/.local/bin/common/status-diskspace"
echo '| color=#aa0000'
