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
        },
    },
    border = "single",
    fzf_opts = {
        ["--layout"] = "default",
        ["--tiebreak"] = "end",
        ["--color"] = "dark,gutter:-1",
    },
    previewers = {
        builtin = {
            syntax_limit_l = require("large_file").LARGE_FILE_LINE_COUNT,
        },
    },
})

vim.keymap.set("n", "cvh", fzf_lua.help_tags)
vim.keymap.set("n", "cvl", fzf_lua.live_grep)

vim.api.nvim_create_user_command("Maps", fzf_lua.keymaps, {})

-- TODO: Find a replacement for
-- vim.keymap.set("i", "<C-X><C-F>", "<Plug>(fzf-complete-path)")

vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("file-list.lua", {}),
    callback = function()
        local file = vim.fn.expand("%:p")
        vim.fn.jobstart({ "fasd", "-A", file }, { detach = true })
    end,
})

vim.keymap.set("n", "cvf", function()
    fzf_lua.fzf_exec("~/.local/bin/common/file-list -t -r", {
        actions = {
            ["default"] = fzf_lua.actions.file_edit,
            ["ctrl-x"] = fzf_lua.actions.file_split,
            ["ctrl-t"] = fzf_lua.actions.file_tabedit,
        },
        previewer = "builtin",
    })
end)

vim.keymap.set("n", "cvg", function()
    fzf_lua.fzf_exec("~/.local/bin/common/file-list -d", {
        actions = {
            ["default"] = function(selected, opts)
                require("fzf-lua.actions").vimcmd("lcd", selected, opts)
            end,
            ["ctrl-x"] = function(selected, _)
                require("open_terminal_fm").open_file_manager(selected[1])
            end,
        },
        fzf_opts = {
            ["--preview"] = fzf_lua.shell.preview_action_cmd(function(items)
                return "exa --tree --color=always " .. items[1]
            end),
        },
    })
end)
