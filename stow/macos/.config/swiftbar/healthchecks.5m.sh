#!/usr/bin/env bash
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>

set -o nounset
set -o errexit

HEALTHCHECKS=$("${HOME}"/.local/bin/common/status-healthchecks)

if [[ $HEALTHCHECKS = *[![:space:]]* ]]; then
    echo "✘ | color=#aa0000 length=10"
    echo '---'
    echo "Healthchecks failed: ${HEALTHCHECKS}... | href=https://healthchecks.io/"
fi
