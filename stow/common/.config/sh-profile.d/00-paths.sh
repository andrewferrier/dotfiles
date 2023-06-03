#!/usr/bin/env bash

XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-${HOME}/.cache/xdg-runtime}" # This will probably only need to be set on MacOS
XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

export XDG_CACHE_HOME
export XDG_CONFIG_HOME
export XDG_DATA_HOME
export XDG_RUNTIME_DIR
export XDG_STATE_HOME

mkdir -pv \
    "${XDG_CACHE_HOME}" \
    "${XDG_CONFIG_HOME}" \
    "${XDG_DATA_HOME}" \
    "${XDG_RUNTIME_DIR}" \
    "${XDG_STATE_HOME}"

GITCO=${HOME}/gitco

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DVDCSS_CACHE="${XDG_DATA_HOME}/dvdcss"
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc2"
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export MINIKUBE_HOME="${XDG_DATA_HOME}/minikube"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_PACKAGES="${XDG_DATA_HOME}/npm" # Defined in ~/.npmrc
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

mkdir -pv \
    "${GEM_HOME}" \
    "${GNUPGHOME}" \
    "${GOPATH}" \
    "${NPM_PACKAGES}" \
    "${XDG_DATA_HOME}/tig"

chmod 700 "${GNUPGHOME}"

pupdate_prepend_single() { [[ -d $1 ]] && case ":${PATH:=$1}:" in *:$1:*) ;; *) PATH="$1:${PATH}" ;; esac }
pupdate_append_singlex() { [[ -d $1 ]] && case ":${PATH:=$1}:" in *:$1:*) ;; *) PATH="${PATH}:$1" ;; esac }
nupdate_append_singlex() { [[ -d $1 ]] && case ":${NODE_PATH:=$1}:" in *:$1:*) ;; *) NODE_PATH="${NODE_PATH}:$1" ;; esac }
pupdate_append_globxxx() {
    glob=$1

    # based on https://stackoverflow.com/a/4264351
    # shellcheck disable=SC2086
    if stat ${glob} >/dev/null 2>/dev/null; then
        IFS=$'\n'
        # shellcheck disable=SC2044
        for dir in $(find -L ${glob} -maxdepth 0 -type d); do
            pupdate_append_singlex "${dir}"
        done
        unset IFS
    fi
}

# generic
pupdate_prepend_single /usr/local/bin
pupdate_prepend_single /usr/local/sbin
pupdate_prepend_single /usr/local/opt/ruby/bin # for brew-installed ruby
pupdate_prepend_single /opt/nvim-linux64/bin
pupdate_prepend_single /opt/homebrew/bin
pupdate_prepend_single /opt/homebrew/sbin
pupdate_prepend_single /opt/homebrew/opt/openssl/bin
pupdate_prepend_single "${HOME}/.deno/bin"
pupdate_append_singlex "${HOME}/.local/bin"
pupdate_append_globxxx "${HOME}/.local/bin/*"
pupdate_append_globxxx "${HOME}/.local/bin/*/*"
pupdate_append_globxxx "${HOME}/.local/bin/*/*/bin"
pupdate_append_singlex "${HOME}/bookmarks/bin"
pupdate_append_singlex /snap/bin
pupdate_append_globxxx "${HOME}/Library/Python/*/bin" # from pip install --user
pupdate_append_singlex "${GITCO}/github/misc-scripts"
pupdate_append_singlex "${GITCO}/github/git-utilities"
pupdate_append_globxxx "/usr/local/texlive/*/bin/x86_64-darwin"
pupdate_append_singlex /usr/share/nodejs/yarn/bin # yarnpkg → yarn
pupdate_append_singlex "${GOPATH}/bin"
pupdate_append_singlex "${GEM_HOME}/bin"
pupdate_append_globxxx "${GEM_HOME}/ruby/*/bin"
pupdate_append_singlex /usr/local/share/dotnet
pupdate_append_singlex "${HOME}/.luarocks/bin" # luarocks/lua
pupdate_append_singlex "${HOME}/.cargo/bin"
pupdate_append_singlex /usr/share/git/git-jump

# node
nupdate_append_singlex "/usr/lib/nodejs"
nupdate_append_singlex "/usr/share/nodejs"

nupdate_append_singlex "/usr/local/lib/node"
nupdate_append_singlex "/usr/local/lib/node_modules"

if command -v npm >/dev/null 2>&1; then
    pupdate_prepend_single "${NPM_PACKAGES}/bin"
    pupdate_append_singlex /usr/local/share/npm/bin
    nupdate_append_singlex "${NPM_PACKAGES}/lib/node_modules"
fi

if command -v yarn >/dev/null 2>&1 || command -v yarnpkg >/dev/null 2>&1; then
    YARN_GLOBAL_DIR="${XDG_DATA_HOME}/yarn/global"
    pupdate_prepend_single "${YARN_GLOBAL_DIR}/bin"
    pupdate_append_globxxx "${YARN_GLOBAL_DIR}/node_modules/*/bin"
    nupdate_append_singlex "${YARN_GLOBAL_DIR}/node_modules"
fi

export NODE_PATH
