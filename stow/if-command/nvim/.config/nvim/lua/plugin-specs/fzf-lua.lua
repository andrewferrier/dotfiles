local configure = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
        winopts = {
            preview = {
                title = false,
                flip_columns = 200,
                scrollbar = false,
                winopts = {
                    cursorline = false,
                    number = false,
                },
                delay = 50,
            },
        },
        fzf_opts = {
            ["--layout"] = "default",
            ["--color"] = "gutter:-1",
            ["--preview-window"] = "border-none",
        },
        grep = {
            rg_opts = "--hidden "
                .. require("fzf-lua.defaults").defaults.grep.rg_opts,
        },
    })

    vim.keymap.set(
        "n",
        "cvh",
        fzf_lua.help_tags,
        { desc = "Open helptag", unique = true }
    )
    vim.keymap.set(
        "n",
        "cvl",
        fzf_lua.live_grep,
        { desc = "Live grep", unique = true }
    )

    vim.keymap.set("n", "cvm", function()
        -- FIXME: `man -c` doesn't work on Arch
        fzf_lua.man_pages({ previewer = "man_native" })
    end, { desc = "Open manpage", unique = true })

    ---@param item string
    local escape = function(item)
        return vim.fn.escape(item, " (){}`'\"")
    end

    vim.keymap.set("n", "cvf", function()
        fzf_lua.fzf_exec("file-list -t -r", {
            actions = require("fzf-lua.config").globals.actions.files,
            fzf_opts = {
                ["--exact"] = "",
                ["--no-sort"] = "",
            },
            previewer = "builtin",
        })
    end, { desc = "Find file", unique = true })

    vim.keymap.set("n", "cvg", function()
        fzf_lua.fzf_exec("file-list -d", {
            actions = {
                ["default"] = function(selected, opts)
                    require("fzf-lua.actions").vimcmd_entry(
                        "lcd",
                        selected,
                        opts
                    )
                end,
                ["ctrl-s"] = function(selected, _)
                    require("open_filedirterm").open_file_manager(selected[1])
                end,
                ["ctrl-d"] = function(selected, _)
                    require("open_filedirterm").open_split_oil(selected[1])
                end,
            },
            fzf_opts = {
                ["--preview"] = fzf_lua.shell.raw_preview_action_cmd(
                    function(items)
                        return "eza --level 2 --tree --color=always --group-directories-first --no-quotes "
                            .. escape(items[1])
                    end
                ),
                ["--no-sort"] = "",
            },
        })
    end, { desc = "Find directory", unique = true })

    vim.keymap.set({ "i" }, "<C-x><C-f>", function()
        require("fzf-lua").complete_file()
    end, { silent = true, desc = "Fuzzy complete path" })
end

return {
    "ibhagwan/fzf-lua",
    config = configure,
    keys = { "cv" },
}
