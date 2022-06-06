vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("skeleton", {}),
    pattern = { "*" },
    callback = function()
        require("skeleton").show_prompt(true)
    end,
})

vim.api.nvim_create_user_command("Skeleton", function()
    require("skeleton").show_prompt(false)
end, {})
