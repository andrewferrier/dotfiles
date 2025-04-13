---@type vim.lsp.Config
return {
    cmd = {
        "tflint",
        "--langserver",
        "--config",
        vim.env.XDG_CONFIG_HOME .. "/.tflint.hcl",
    },
}
