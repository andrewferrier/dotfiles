if vim.fn.has("nvim-0.10.0") == 0 then
    vim.api.nvim_create_user_command("InspectTree", function()
        require("vim.treesitter.playground").inspect_tree()
    end, {})
end
