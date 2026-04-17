local M = {}

vim.api.nvim_create_user_command("VimPackUpdate", function(_)
    vim.pack.update(nil)
end, {})

return M
