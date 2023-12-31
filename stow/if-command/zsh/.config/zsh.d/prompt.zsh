# based on lean
# by Miek Gieben: https://github.com/miekg/lean

readonly COLOR_SECONDARY="%F{8}" # grey
readonly COLOR_PRIMARY="%F{2}" # green
readonly COLOR_WARNING="%F{9}" # red
readonly COLOR_ERROR="%F{1}" # bright red

PROMPT_CMD_MAX_EXEC_TIME=${PROMPT_CMD_MAX_EXEC_TIME:=60}

human_readable_time() {
    local tmp=$1
    local days=$(( tmp / 60 / 60 / 24 ))
    local hours=$(( tmp / 60 / 60 % 24 ))
    local minutes=$(( tmp / 60 % 60 ))
    local seconds=$(( tmp % 60 ))
    (( $days > 0 )) && echo -n "${days}d "
    (( $hours > 0 )) && echo -n "${hours}h "
    (( $minutes > 0 )) && echo -n "${minutes}m "
    echo "${seconds}s "
}

prompt_cmd_exec_time() {
    local stop=$EPOCHSECONDS
    local start=${cmd_timestamp:-$stop}
    integer elapsed=$stop-$start
    (($elapsed > $PROMPT_CMD_MAX_EXEC_TIME)) && human_readable_time $elapsed
}

prompt_preexec() {
    cmd_timestamp=$EPOCHSECONDS
}

prompt_pwd() {
    print -Pn '%~'
}

prompt_nested() {
    [ -n "$NCDU_LEVEL" ] && echo -n '(ncdu) '
    [ -n "$VIRTUAL_ENV" ] && echo -n "(venv $(basename $VIRTUAL_ENV)) "
}

prompt_precmd() {
    local prompt_jobs
    local jobs

    unset jobs
    for a (${(k)jobstates}) {
        j=$jobstates[$a];i='${${(@s,:,)j}[2]}'
        jobs+=($a${i//[^+-]/})
    }

    prompt_jobs=""
    [[ -n $jobs ]] && prompt_jobs="["${(j:,:)jobs}"] "

    setopt promptsubst

    readonly RESET_FORMATTING="%f%k%b"

    PROMPT="${COLOR_SECONDARY}${prompt_jobs}$(prompt_nested)"
    PROMPT="${PROMPT}%(?.${COLOR_PRIMARY}.%B${COLOR_ERROR})%#${RESET_FORMATTING} "

    GIT_INCLUDE="${GITSTATUS_PROMPT}"
    [[ ! -z $GIT_INCLUDE ]] && GIT_INCLUDE=" ${GIT_INCLUDE}"

    RPROMPT="${COLOR_WARNING}$(prompt_cmd_exec_time)"
    RPROMPT="${RPROMPT}${COLOR_PRIMARY}$(prompt_pwd)"

    RPROMPT="${RPROMPT}${COLOR_SECONDARY}${GIT_INCLUDE}"
    RPROMPT="${RPROMPT}$prompt_host"

    unset cmd_timestamp # reset value since `preexec` isn't always triggered

    if type day-night-terminal-setup >/dev/null; then
        . day-night-terminal-setup
    fi
}

prompt_opts=(cr percent sp subst)

zmodload zsh/datetime
autoload -Uz add-zsh-hook

add-zsh-hook precmd prompt_precmd
add-zsh-hook preexec prompt_preexec

if [[ "$SSH_CONNECTION" != '' ]]; then
    prompt_host=" ${COLOR_WARNING}%m"
fi
