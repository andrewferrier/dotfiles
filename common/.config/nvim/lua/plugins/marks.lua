require("marks").setup({
    builtin_marks = { "^", "<", ">" },
    force_write_shada = true,
    sign_priority = { lower = 11, upper = 11, builtin = 1, bookmark = 11 },
    -- Disabling some of these keys is important so that `dm` is not overloaded
    -- and can be used with nvim-treehopper
    mappings = {
        delete = false,
        delete_bookmark = false,
        delete_bookmark0 = false,
        delete_bookmark1 = false,
        delete_bookmark2 = false,
        delete_bookmark3 = false,
        delete_bookmark4 = false,
        delete_bookmark5 = false,
        delete_bookmark6 = false,
        delete_bookmark7 = false,
        delete_bookmark8 = false,
        delete_bookmark9 = false,
        delete_buf = "m<space>",
        delete_line = false,
        next = false,
        next_bookmark = false,
        prev = false,
        prev_bookmark = false,
        preview = false,
    },
    excluded_filetypes = { "fzf" },
})

vim.api.nvim_create_user_command("MarksQFListBuf", function()
    require("marks").mark_state:buffer_to_list("quickfixlist")
    require("quickfix").open()
end, {})

vim.api.nvim_create_user_command("MarksQFListGlobal", function()
    require("marks").mark_state:global_to_list("quickfixlist")
    require("quickfix").open()
end, {})

vim.api.nvim_create_user_command("MarksQFListAll", function()
    require("marks").mark_state:all_to_list("quickfixlist")
    require("quickfix").open()
end, {})
