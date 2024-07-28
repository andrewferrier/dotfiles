local configure = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
        winopts = {
            width = 0.9,
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
            border = { " ", " ", " ", " ", " ", " ", " ", " " },
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
        require("fzf-lua.devicons").load({ plugin = "mini" })

        -- FIXME: Not quite clear why the 4000 limit is needed, but NeoVim
        -- crashes otherwise
        fzf_lua.fzf_exec("file-list -t -r -p | head -4000", {
            actions = require("fzf-lua.config").globals.actions.files,
            fzf_opts = {
                ["--exact"] = "",
                ["--no-sort"] = "",
            },
            previewer = "builtin",
            fn_transform = function(filename)
                return require("fzf-lua").make_entry.file(
                    filename,
                    { file_icons = true, color_icons = true }
                )
            end,
        })
    end, { desc = "Find file", unique = true })

    vim.keymap.set("n", "cvg", function()
        fzf_lua.fzf_exec("file-list -d", {
            actions = {
                ["default"] = function(selected, opts)
                    require("fzf-lua.actions").vimcmd("lcd", selected, opts)
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
