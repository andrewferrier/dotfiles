vim.opt_local.wrap = true
vim.opt_local.signcolumn = "no"

require("utils").buf_set_q_key_to_quit()

-- See https://www.reddit.com/r/neovim/comments/1isd2wl/comment/mdfr7gi/
vim.api.nvim_buf_clear_namespace(
    0,
    vim.api.nvim_create_namespace("nvim.vimdoc.run_message"),
    0,
    -1
)
