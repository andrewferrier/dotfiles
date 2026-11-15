#!/usr/bin/env bash

set -o errexit
set -o noglob
set -o nounset

write-usb() {
    local iso="${1:?First param is image.iso}"
    local dev="${2:?Second param is device e.g. /dev/sda}"

    if [[ ! -f "$iso" || ! -r "$iso" ]]; then
        echo "Error: ISO does not exist or is not readable: $iso"
        return 1
    fi

    if [[ ! -b "$dev" ]]; then
        echo "Error: Not a block device: $dev"
        return 1
    fi

    if lsblk -dn -o TYPE "$dev" | grep -qv '^disk$'; then
        echo "Error: Target must be a whole disk, e.g. /dev/sdb"
        return 1
    fi

    echo "WARNING: ALL DATA ON $dev WILL BE DESTROYED! Type YES to continue."

    read -r answer
    [[ "$answer" == "YES" ]] || {
        echo "Cancelled."
        return 1
    }

    sudo dd if="$iso" of="$dev" bs=4M status=progress oflag=sync
    sync

    echo "Successfully written: $iso -> $dev"
}
