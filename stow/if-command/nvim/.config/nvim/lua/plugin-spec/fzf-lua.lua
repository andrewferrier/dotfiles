local configure = function()
    local fzf_lua = require("fzf-lua")

    fzf_lua.setup({
        winopts = {
            height = 0.9,
            width = 0.9,
            preview = {
                title = false,
                flip_columns = 200,
            },
        },
        fzf_opts = {
            ["--layout"] = "default",
            ["--color"] = "gutter:-1",
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
        -- `man -c` doesn't work on Arch
        fzf_lua.man_pages({ previewer = "man_native" })
    end, { desc = "Open manpage", unique = true })

    local cvf_previewer
    local ESCAPE_CHARS = " (){}`'\""

    if vim.fn.executable("batcat") == 1 then
        cvf_previewer = function(items)
            return "batcat --style=plain --color=always "
                .. vim.fn.escape(items[1], ESCAPE_CHARS)
        end
    elseif vim.fn.executable("bat") == 1 then
        cvf_previewer = function(items)
            return "bat --style=plain --color=always "
                .. vim.fn.escape(items[1], ESCAPE_CHARS)
        end
    else
        cvf_previewer = function(items)
            return "cat " .. vim.fn.escape(items[1], ESCAPE_CHARS)
        end
    end

    vim.keymap.set("n", "cvf", function()
        fzf_lua.fzf_exec("file-list -t -r", {
            actions = require("fzf-lua.config").globals.actions.files,
            fzf_opts = {
                ["--preview"] = fzf_lua.shell.preview_action_cmd(cvf_previewer),
                ["--exact"] = "",
                ["--no-sort"] = "",
            },
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
                ["--preview"] = fzf_lua.shell.preview_action_cmd(
                    function(items)
                        return "exa --level 2 --tree --color=always --group-directories-first "
                            .. vim.fn.escape(items[1], " ")
                    end
                ),
                ["--no-sort"] = "",
            },
        })
    end, { desc = "Find directory", unique = true })

    vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
        require("fzf-lua").complete_path()
    end, { silent = true, desc = "Fuzzy complete path", unique = true })
end

return {
    "ibhagwan/fzf-lua",
    config = configure,
    keys = { "cv" },
}
