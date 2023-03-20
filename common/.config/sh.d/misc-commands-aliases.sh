#!/usr/bin/env bash

alias aria2c='aria2c --max-connection-per-server=5'
alias docker-cleanup="docker container prune -f ; docker image prune -f ; docker volume prune -f ; docker network prune -f"
alias docker-rmi-interactive="docker images | sed -E 's%([^[:space:]]+)[[:space:]]+([^[:space:]]+)[[:space:]]+([^[:space:]]+).*%\\1:\\2 \\3%g' | tail -n +2 | sort -r | fzf -d' ' -m --with-nth=1 | cut -d' ' -f2 | xargs -t docker image rm"
alias external-ip="curl -4 ifconfig.co"
alias icat='kitty +kitten icat'
alias speedtest="docker run --rm --net=host docker.io/tianon/speedtest --accept-license --accept-gdpr"
alias testssl='docker run -t --rm docker.io/mvance/testssl'

if [[ ${OSTYPE} == darwin* ]]; then
    alias cp='cp -v'
    alias df='df -Ph'
    alias listening="sudo lsof -iTCP -sTCP:LISTEN -n -P"
    alias ps='pstree -g 3'
    alias sshfs='sshfs -o noapplexattr,noappledouble'
    alias sudo="sudo -p '[sudo] %p'\\''s password: '"
else
    alias cp='cp -v --sparse=always --reflink=auto'
    alias df='df --print-type --human-readable'
    alias listening='sudo ss --listening --tcp --udp --numeric --process'
    alias lsblk='lsblk -o NAME,MOUNTPOINT,FSUSED,SIZE,TYPE,FSTYPE,UUID,LABEL,PARTLABEL --paths'
    alias ps='ps -e -f --forest'
    alias rm='rm -I'
    alias sparseness="find . -type f -printf '%S\t%p\n' | column -t -s $'\t' | sort -n -r"
fi

if [[ ${OSTYPE} == darwin* ]]; then
    # http://superuser.com/a/341429/3021
    function bundleid() {
        osascript -e "id of app \"$*\""
    }

    function getuti() {
        local f="/tmp/me.lri.getuti.${1##*.}"
        touch "${f}"
        mdimport "${f}"
        mdls -name kMDItemContentTypeTree "${f}"
        rm "${f}"
    }
else
    function mount-external {
        DEVICE_BASE=$1
        DEVICE=/dev/$DEVICE_BASE

        if [[ -b ${DEVICE} ]]; then
            MOUNTPOINT=/mnt/$DEVICE_BASE

            sudo mkdir -p "$MOUNTPOINT"
            sudo chmod a+rwX "$MOUNTPOINT"

            FILESYSTEM=$(sudo blkid -o value -s TYPE "${DEVICE}")

            if [[ $FILESYSTEM == ext* ]]; then
                sudo mount -v -o users,gid=users "$DEVICE" "$MOUNTPOINT"
            elif [[ $FILESYSTEM == iso9660 ]]; then
                sudo mount -v "$DEVICE" "$MOUNTPOINT"
            else
                sudo mount -v -o users,gid=users,fmask=113,dmask=002 "$DEVICE" "$MOUNTPOINT"
            fi
        else
            echo >&2 "${DEVICE} does not exist."
        fi
    }
fi

if (command -v fallocate >/dev/null 2>&1); then
    function make-sparse() {
        for filename in "$@"; do
            fallocate --dig-holes --verbose "${filename}"
        done
    }
fi

if (command -v gmake >/dev/null 2>&1); then
    alias make='gmake'
fi

if (! command -v smbclient >/dev/null 2>&1); then
    alias smbclient='docker run --rm -ti docker.io/kfaughnan/smbclient'
fi

function mkdir-mail {
    readonly MAILDIR=$1
    mkdir -p "${MAILDIR}/cur" "${MAILDIR}/new" "${MAILDIR}/tmp"
    touch "${MAILDIR}/cur/.gitkeep" "${MAILDIR}/new/.gitkeep" "${MAILDIR}/tmp/.gitkeep"
}

function take() {
    # shellcheck disable=SC2164
    mkdir -p "$@" && cd "${@:$#}"
}
