local configure = function()
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
        border = "thicc",
        fzf_opts = {
            ["--layout"] = "default",
            ["--color"] = "dark,gutter:-1",
        },
    })

    vim.keymap.set("n", "cvh", fzf_lua.help_tags, { desc = "Open helptag" })
    vim.keymap.set("n", "cvl", fzf_lua.live_grep, { desc = "Live grep" })

    vim.keymap.set("n", "cvm", function()
        -- `man -c` doesn't work on Arch
        fzf_lua.man_pages({ previewer = "man_native" })
    end, { desc = "Open manpage" })

    vim.keymap.set("n", "cvf", function()
        fzf_lua.fzf_exec("~/.local/bin/common/file-list -t -r", {
            actions = require("fzf-lua.config").globals.actions.files,
            previewer = "builtin",
            fzf_opts = {
                ["--exact"] = "",
                ["--no-sort"] = "",
            },
        })
    end, { desc = "Find file" })

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
                ["--preview"] = fzf_lua.shell.preview_action_cmd(
                    function(items)
                        return "exa --level 2 --tree --color=always --group-directories-first "
                            .. vim.fn.escape(items[1], " ")
                    end
                ),
                ["--no-sort"] = "",
            },
        })
    end, { desc = "Find directory" })

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
        require("fzf-lua").complete_path()
    end, { silent = true, desc = "Fuzzy complete path" })
end

return {
    "ibhagwan/fzf-lua",
    config = configure,
    keys = { "cv" },
}
