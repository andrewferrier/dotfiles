#!/usr/bin/env bash

alias combine-into-pdf='convert -density 300 -quality 100'
alias docker-cleanup="docker container prune -f ; docker image prune -f ; docker volume prune -f ; docker network prune -f"
alias docker-rmi-interactive="docker images | sed -E 's%([^[:space:]]+)[[:space:]]+([^[:space:]]+)[[:space:]]+([^[:space:]]+).*%\\1:\\2 \\3%g' | tail -n +2 | sort -r | fzf -d' ' -m --with-nth=1 | cut -d' ' -f2 | xargs -t docker image rm"
alias external-ip="curl -4 ifconfig.co"
alias find-case-insensitive-clashes="find . | tr '[:upper:]' '[:lower:]' | LC_ALL=C sort | LC_ALL=C uniq -d"
alias lpr-onesided='lpr -o sides=one-sided'
alias lpr-twosided='lpr -o sides=two-sided-long-edge'
alias reenable-printer='lpq | head -1 | cut -d" " -f1 | xargs lpadmin -E -p'
alias rm-broken-links='find . -xtype l | fzf -m | xargs rm'
alias socks-ssh-setup='ssh -f -N -D 1080 '
alias speedtest="docker run --rm --net=host docker.io/tianon/speedtest --accept-license --accept-gdpr"
alias ssh-audit='docker run -it -p 2222:2222 docker.io/positronsecurity/ssh-audit'
alias testssl='docker run -t --rm docker.io/mvance/testssl'
alias webshare='python3 -m http.server'
alias wgetmirror='wget --execute robots=off --mirror --page-requisites --adjust-extension --no-parent --convert-links'

if [[ ${OSTYPE} == darwin* ]]; then
    alias listening="sudo lsof -iTCP -sTCP:LISTEN -n -P"
else
    alias journalctl-fzf='SYSTEMD_COLORS=true journalctl -f --lines all --output=short-iso | fzf --tail=1000000 --tac --no-sort --ansi'
    alias listening='sudo ss --listening --tcp --udp --numeric --process'
    alias monitor-wifi='watch "nmcli --colors yes device wifi list"'
    alias sparseness="find . -type f -printf '%S\t%p\n' | column -t -s $'\t' | sort -n -r"
fi

if [[ -n $VISUAL ]]; then
    # shellcheck disable=SC2139
    alias vi="${VISUAL}"
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

function take() {
    # shellcheck disable=SC2164
    mkdir -p "$@" && cd "${@:$#}"
}
