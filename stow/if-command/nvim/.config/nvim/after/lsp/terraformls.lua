---@type vim.lsp.Config
return {
    cmd = {
        "terraform-ls",
        "serve",
        "-log-file=" .. vim.fn.stdpath("log") .. "/terraform-ls.log",
    },
}
