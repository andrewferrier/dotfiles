local fzf_lua = require("fzf-lua")

fzf_lua.setup({
    winopts = {
        height = 0.9,
        width = 0.9,
        preview = {
            title = false,
            winopts = {
                number = false,
            },
            flip_columns = 200,
        },
    },
    border = "single",
    fzf_opts = {
        ["--layout"] = "default",
        ["--color"] = "dark,gutter:-1",
    },
})

vim.keymap.set("n", "cvh", fzf_lua.help_tags)
vim.keymap.set("n", "cvl", fzf_lua.live_grep)

vim.keymap.set("n", "cvm", function()
    -- `man -c` doesn't work on Arch
    fzf_lua.man_pages({ previewer = "man_native" })
end)

vim.keymap.set("n", "cvf", function()
    fzf_lua.fzf_exec("~/.local/bin/common/file-list -t -r", {
        actions = require("fzf-lua.config").globals.actions.files,
        previewer = "builtin",
        fzf_opts = {
            ["--exact"] = "",
            ["--no-sort"] = "",
        },
    })
end)

vim.keymap.set("n", "cvg", function()
    fzf_lua.fzf_exec("~/.local/bin/common/file-list -d", {
        actions = {
            ["default"] = function(selected, opts)
                require("fzf-lua.actions").vimcmd("lcd", selected, opts)
            end,
            ["ctrl-s"] = function(selected, _)
                require("open_filedirterm").open_file_manager(selected[1])
            end,
            ["ctrl-d"] = function(selected, _)
                require("open_filedirterm").open_split_dirbuf(selected[1])
            end,
        },
        fzf_opts = {
            ["--preview"] = fzf_lua.shell.preview_action_cmd(function(items)
                return "exa --level 2 --tree --color=always --group-directories-first "
                    .. vim.fn.escape(items[1], " ")
            end),
            ["--no-sort"] = "",
        },
    })
end)

-- Workaround for warning, see https://github.com/ibhagwan/fzf-lua/issues/589
local buffer_is_dirty_orig = require("fzf-lua.utils").buffer_is_dirty

require("fzf-lua.utils").buffer_is_dirty = function(bufnr, _, only_if_last_buffer)
    buffer_is_dirty_orig(bufnr, false, only_if_last_buffer)
end
