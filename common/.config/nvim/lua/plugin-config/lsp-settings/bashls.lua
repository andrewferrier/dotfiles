return {
    -- Disable shellcheck because we use it from null-ls where we have more control
    cmd_env = { SHELLCHECK_PATH = "" },
}
