return {
    cmd = {
        "terraform-ls",
        "serve",
        "-log-file=" .. vim.fn.stdpath("state") .. "/terraform-ls.log",
    },
}
