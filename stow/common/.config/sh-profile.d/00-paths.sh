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

export ANSIBLE_HOME="${XDG_DATA_HOME}/ansible"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DVDCSS_CACHE="${XDG_DATA_HOME}/dvdcss"
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc2"
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export K9SCONFIG="${XDG_CONFIG_HOME}/k9s"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export MINIKUBE_HOME="${XDG_DATA_HOME}/minikube"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_PACKAGES="${XDG_DATA_HOME}/npm" # Defined in ~/.npmrc
export PYTHON_HISTORY="${XDG_DATA_HOME}/python/history" # Will start working in Python 3.13+: https://unix.stackexchange.com/a/768595
export RANDFILE="${XDG_STATE_HOME}/.rnd"
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"
export W3M_DIR="${XDG_DATA_HOME}/w3m"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

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
        # shellcheck disable=SC2044
        for dir in $(find -L ${glob} -maxdepth 0 -type d); do
            pupdate_append_singlex "${dir}"
        done
    fi
}

# generic
pupdate_prepend_single /usr/local/bin
pupdate_prepend_single /usr/local/sbin
pupdate_prepend_single /usr/local/opt/ruby/bin # for brew-installed ruby
pupdate_prepend_single /opt/homebrew/bin
pupdate_prepend_single /opt/homebrew/sbin
pupdate_prepend_single /opt/homebrew/opt/openssl/bin

if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX_PYTHON=$(brew --prefix python)
    pupdate_prepend_single "${BREW_PREFIX_PYTHON}/libexec/bin"
fi

pupdate_prepend_single "${HOME}/.deno/bin"

pupdate_append_singlex "${HOME}/.local/bin"
pupdate_append_globxxx "${HOME}/.local/bin/*"
pupdate_append_globxxx "${HOME}/.local/bin/*/bin"
pupdate_append_globxxx "${HOME}/.local/bin/*/*/bin"
pupdate_append_singlex "${XDG_DATA_HOME}/bob/nvim-bin"
pupdate_append_singlex "${HOME}/bookmarks/bin"
pupdate_append_globxxx "${HOME}/Library/Python/*/bin" # from pip install --user
pupdate_append_singlex "${GOPATH}/bin"
pupdate_append_singlex "${GEM_HOME}/bin"
pupdate_append_globxxx "${GEM_HOME}/ruby/*/bin"
pupdate_append_singlex "${HOME}/.luarocks/bin" # luarocks/lua
pupdate_append_singlex "${HOME}/.cargo/bin"
pupdate_append_singlex "${HOME}/.local/share/cargo/bin"
pupdate_append_singlex "${HOME}/memy/target/debug"

if command -v npm >/dev/null 2>&1; then
    nupdate_append_singlex "${NPM_PACKAGES}/lib/node_modules"
    nupdate_append_singlex /usr/lib/nodejs
    nupdate_append_singlex /usr/local/lib/node
    nupdate_append_singlex /usr/local/lib/node_modules
    nupdate_append_singlex /usr/share/nodejs
    pupdate_append_singlex /usr/local/share/npm/bin
    pupdate_prepend_single "${NPM_PACKAGES}/bin"
fi

export NODE_PATH

if command -v lua5.1 &>/dev/null; then
    LUAROCKS_PATH=$(luarocks path --no-bin --lua-version 5.1)
    # shellcheck disable=SC2086
    eval $LUAROCKS_PATH
fi
