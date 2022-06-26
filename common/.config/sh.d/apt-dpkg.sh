#!/usr/bin/env bash

if (command -v aptitude >/dev/null 2>&1); then
    alias apt-clean-packages="sudo apt-get autoremove && sudo dpkg --purge \$(apt-leaves | fzf --multi --layout=reverse --preview 'dpkg -s {}')"
    alias apt-obsolete='aptitude search "~o"'
    alias dpkg-installbuilddependencies="sudo apt-get install --yes \$(dpkg-checkbuilddeps 2>&1 | sed 's/dpkg-checkbuilddeps:\serror:\sUnmet build dependencies: //g' | sed 's/[\(][^)]*[\)] //g')"
fi
