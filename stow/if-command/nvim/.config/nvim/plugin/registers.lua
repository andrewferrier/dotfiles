vim.api.nvim_create_user_command("EmptyRegisters", function()
    for c in
        ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):gmatch(".")
    do
        -- See https://github.com/neovim/neovim/issues/4444#issuecomment-195810512
        vim.cmd({ cmd = "rshada" })
        vim.cmd({ cmd = "call", args = { "setreg ('" .. c .. "', [])" } })
        vim.cmd({ cmd = "wshada", bang = true })
    end
end, {})
