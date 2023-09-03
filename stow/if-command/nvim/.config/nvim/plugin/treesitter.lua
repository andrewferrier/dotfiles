vim.api.nvim_create_user_command("TSInspect", function(opts)
    if vim.fn.has("nvim-0.10.0") == 1 then
        require("vim.treesitter.dev").inspect_tree()
    else
        require("vim.treesitter.playground").inspect_tree()
    end
end, {})
